//
//  StructView.swift
//  CLALeakSample
//
//  Created by Yamada Shunya on 2019/11/14.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

// MARK: - Interface

protocol StructView: AnyObject {
    func updateDataSource(_ dataSource: [StructSection])
}

// MARK: - Implementation

final class StructViewController: BaseViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet private weak var collapsibleView: UIView!
    
    // MARK: Properties
    
    private var presenter: StructPresenter!
    private var dataSource: [StructSection] = [StructSection]() {
        didSet {
            collectionView.reloadData()
        }
    }
    private lazy var didAppearInit: Void = {
        if isBeingPresented {
            UIView.animate(withDuration: 0.3) {
                self.collapsibleView.isHidden = false
            }
        }
    }()
    
    // MARK: Lifecycle
    
    func inject(presenter: StructPresenter) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter.get()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        _ = didAppearInit
    }
    
    // MARK: IBAction
    
    @IBAction func onTapCloseButton(_ sender: UIButton) {
        presenter.dismiss()
    }
    
}

extension StructViewController: StructView {
    
    func updateDataSource(_ dataSource: [StructSection]) {
        self.dataSource = dataSource
    }
}

// MARK: - Setup

extension StructViewController {
    
    private func setup() {
        // - View
        collapsibleView.isHidden = true
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

extension StructViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
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
