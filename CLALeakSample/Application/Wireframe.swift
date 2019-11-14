//
//  Wireframe.swift
//  CLALeakSample
//
//  Created by Yamada Shunya on 2019/11/14.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

// MARK: - Interface

protocol Wireframe {
    func dismiss() 
}

// MARK: - Implementation

struct WireframeImpl: Wireframe {
    
    // MARK: Properties
    
    // POINT: ① Wireframe <-> ViewController の参照がこのままではdeinitされなかったので[weak]に変更してみる
    // → Repositoryがsingletonを持つ場合はrepositoryはdeinitされなかった
    private weak var viewController: UIViewController?
    
    // MARK: Initializer
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func dismiss() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
