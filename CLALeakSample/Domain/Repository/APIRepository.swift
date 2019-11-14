//
//  APIRepository.swift
//  CLALeakSample
//
//  Created by Yamada Shunya on 2019/11/14.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Interface

protocol APIRepository {
    func get() -> Observable<[PostEntity]>
}

// MARK: - Implementation

struct APIRepositoryImpl: APIRepository {
    
    // MARK: Dependency
    
    private let apiProvider: APIProvider
    
    // MARK: Initializer
    
    init(apiProvider: APIProvider) {
        self.apiProvider = apiProvider
    }
    
    // MARK: API
    
    func get() -> Observable<[PostEntity]> {
        return apiProvider.get()
    }
}
