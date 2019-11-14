//
//  PostCell.swift
//  CLALeakSample
//
//  Created by Yamada Shunya on 2019/11/14.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

class PostCell: UICollectionViewCell {
    
    // MARK: IBOutlet
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bodyLabel: UILabel!
    @IBOutlet private weak var userLabel: UILabel!
    
    // MARK: Properties
    
    static let reuseIdentifier = "PostCell"
    static var nib: UINib {
        return UINib(nibName: "PostCell", bundle: nil)
    }
    
    // MARK: Lifcycle

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundView = UIView()
        backgroundView?.backgroundColor = .systemBackground
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
    }

    // MARK: Setup
    
    func setupCell(title: String, body: String, user: String) {
        titleLabel.text = title
        bodyLabel.text = body
        userLabel.text = user
    }
}
