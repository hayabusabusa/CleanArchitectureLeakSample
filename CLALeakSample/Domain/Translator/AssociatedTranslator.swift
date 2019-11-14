//
//  AssociatedTranslator.swift
//  CLALeakSample
//
//  Created by Yamada Shunya on 2019/11/14.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation
import RxSwift

public protocol AssociatedTranslator {
    associatedtype Entity
    associatedtype Model

    func translate(_ entity: Entity) throws -> Model
}

public extension ObservableType {
    func mapTranslator<T: AssociatedTranslator>(_ translator: T) -> Observable<T.Model> where Self.Element == T.Entity {
        return map { try translator.translate($0) }
    }
}

extension PrimitiveSequenceType where Self.Trait == SingleTrait {
    func mapTranslator<T: AssociatedTranslator>(_ translator: T) -> PrimitiveSequence<Trait, T.Model> where Self.Element == T.Entity {
        return primitiveSequence.map { try translator.translate($0) }
    }
}

extension Collection {
    public func map<T: AssociatedTranslator>(translator: T) throws -> [T.Model] where Self.Iterator.Element == T.Entity {
        return try map { try translator.translate($0) }
    }
}
