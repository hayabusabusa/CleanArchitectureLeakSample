//
//  DirectlyView.swift
//  CLALeakSample
//
//  Created by Yamada Shunya on 2019/11/14.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit
import RxSwift

// MARK: - Interface

protocol DirectlyView: AnyObject {
    
}

// MARK: - Implementation

/// APIProviderを直接持つViewController
///
/// - Note: Dependency
///   - APIProvider
final class DirectlyViewController: BaseViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: Properties
    
    var apiProvider: APIProvider!
    private var dataSource: [DirectlySection] = [DirectlySection]()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // - GET
        apiProvider.get()
        .subscribe(onNext: { [weak self] entities in
            guard let self = self else { return }
            self.dataSource = [DirectlySection.content(viewModels: entities.map { Post($0) })]
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }, onError: { error in
            print(error)
        })
        .disposed(by: disposeBag)
    }
}

extension DirectlyViewController: DirectlyView {
    
}

// MARK: - Setup

extension DirectlyViewController {
    
    private func setup() {
        // - Navigation
        navigationItem.title = "StructAPIProvider"
        // - CollectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PostCell.nib, forCellWithReuseIdentifier: PostCell.reuseIdentifier)
        collectionView.setCollectionViewLayout(createLayout(), animated: false)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section, _) -> NSCollectionLayoutSection? in
            return self.dataSource[section].layout
        }
        return layout
    }
}

// MARK: - CollectionView dataSource, delegate

extension DirectlyViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource[section].numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch dataSource[indexPath.section] {
        case .content(let viewModels):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCell.reuseIdentifier, for: indexPath) as! PostCell
            let viewModel = viewModels[indexPath.row]
            cell.setupCell(title: viewModel.title, body: viewModel.body, user: "userID: \(viewModel)")
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
