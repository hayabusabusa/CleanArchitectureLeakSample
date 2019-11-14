//
//  APIUseCase.swift
//  CLALeakSample
//
//  Created by Yamada Shunya on 2019/11/14.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - Interface

protocol APIUseCase {
    func get() -> Observable<[Post]>
}

// MARK: - Implementation

struct APIUseCaseImpl: APIUseCase {
    
    // MARK: Dependency
    
    private let repository: APIRepository
    
    // MARK: Initializer
    
    init(repository: APIRepository) {
        self.repository = repository
    }
    
    // MARK: API
    
    func get() -> Observable<[Post]> {
        return repository.get().mapTranslator(PostTranslator())
    }
}
