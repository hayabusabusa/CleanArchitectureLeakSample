//
//  Builder.swift
//  CLALeakSample
//
//  Created by Yamada Shunya on 2019/11/14.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit

// MARK: - Interface

protocol Builder {
    func build(_ type: BuildType) -> UIViewController
}

// MARK: - Implementation

struct BuilderImpl: Builder {
    
    func build(_ type: BuildType) -> UIViewController {
        switch type {
        case .structType:
            let vc = StructViewController.newInstance()
            vc.inject(
                presenter: StructPresenterImpl(
                    view: vc,
                    wireframe: WireframeImpl(vc),
                    useCase: APIUseCaseImpl(
                        repository: APIRepositoryImpl(apiProvider: StructAPIProvider())
                    )
                )
            )
            return vc
        case .useCaseType:
            let vc = UseCaseViewController.newInstance()
            vc.inject(
                useCase: APIUseCaseImpl(
                    repository: APIRepositoryImpl(apiProvider: SingletoneAPIProvider.shared) // 同じようにひとまずSingleton
                )
            )
            return vc
        case .directlyType:
            let vc = DirectlyViewController.newInstance()
            vc.inject(apiProvider: SingletoneAPIProvider.shared)
            return vc
        case .disposedType:
            let vc = DisposeViewController.newInstance()
            vc.inject(apiProvider: SingletoneAPIProvider.shared)
            return vc
        }
    }
}

// MARK: - Enum

enum BuildType {
    case structType
    case useCaseType
    case directlyType
    case disposedType
}
