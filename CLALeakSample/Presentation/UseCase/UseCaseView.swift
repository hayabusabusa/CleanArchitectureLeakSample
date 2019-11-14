//
//  UseCaseView.swift
//  CLALeakSample
//
//  Created by Yamada Shunya on 2019/11/14.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit
import RxSwift

// MARK: - Interface

protocol UseCaseView: AnyObject {
    
}

// MARK: - Implementation

/// UseCaseを直接持つViewController
///
/// - Note: Dependency
///   - UseCase-Repository-APIProvider
final class UseCaseViewController: BaseViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: Properties
    
    private var useCase: APIUseCase!
    private var dataSource: [UseCaseSection] = [UseCaseSection]()
    
    // MARK: Lifecycle
    
    func inject(useCase: APIUseCase) {
        self.useCase = useCase
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        get()
    }
    
    deinit {
        print("\(type(of: self)) was deinit")
    }
}

extension UseCaseViewController: UseCaseView {
    
}

// MARK: - Setup

extension UseCaseViewController {
    
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
        let layout = UICollectionViewCompositionalLayout { [weak self] (section, _) -> NSCollectionLayoutSection? in
            guard let self = self else { return nil }
            return self.dataSource[section].layout
        }
        return layout
    }
}

// MARK: - UseCase

extension UseCaseViewController {
    
    func get() {
        useCase.get()
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] viewModels in
                guard let self = self else { return }
                self.dataSource = [UseCaseSection.content(viewModels: viewModels)]
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - CollectionView dataSource, delegate

extension UseCaseViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
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
