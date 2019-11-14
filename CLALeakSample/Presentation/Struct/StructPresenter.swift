//
//  StructPresenter.swift
//  CLALeakSample
//
//  Created by Yamada Shunya on 2019/11/14.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Interface

protocol StructPresenter: AnyObject {
    // - API
    func get()
    // - Wireframe
    func pushSameVC()
    func dismiss()
}

// MARK: - Implementation

class StructPresenterImpl: StructPresenter {
    
    // MARK: Properties
    
    private weak var view: StructView?
    private let wireframe: Wireframe
    private let useCase: APIUseCase
    private let disposeBag = DisposeBag()
    
    // MARK: Initializer
    
    init(view: StructView, wireframe: Wireframe, useCase: APIUseCase) {
        self.view = view
        self.wireframe = wireframe
        self.useCase = useCase
    }
    
    deinit {
        print("\(type(of: self)) was deinit.")
    }
    
    // MARK: API
    
    func get() {
        useCase.get()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] viewModels in
                guard let self = self else { return }
                self.view?.updateDataSource([StructSection.content(viewModels: viewModels)])
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: Wireframe
    
    func pushSameVC() {
        wireframe.pushSameVC()
    }
    
    func dismiss() {
        wireframe.dismiss()
    }
}
