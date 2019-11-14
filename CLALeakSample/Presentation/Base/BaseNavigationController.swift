//
//  BaseNavigationController.swift
//  Holder
//
//  Created by Yamada Shunya on 2019/09/10.
//  Copyright © 2019 山田隼也. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    // MARK: Overrides

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        super.pushViewController(viewController, animated: animated)
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - UI

extension BaseNavigationController {

    func setupUI() {
        view.backgroundColor = .systemBackground
        navigationBar.shadowImage = UIImage()
        //navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 16, weight: .bold)]
    }
}
