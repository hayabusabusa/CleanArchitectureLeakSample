//
//  StructSection.swift
//  CLALeakSample
//
//  Created by Yamada Shunya on 2019/11/14.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

enum StructSection {
    case content(viewModels: [Post])
    
    var numberOfItems: Int {
        switch self {
        case .content(let viewModels):
            return viewModels.count
        }
    }
    
    var layout: NSCollectionLayoutSection {
        switch self {
        case .content:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 8.0
            return section
        }
    }
}
