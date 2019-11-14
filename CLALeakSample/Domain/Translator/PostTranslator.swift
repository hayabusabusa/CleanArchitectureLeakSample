//
//  PostTranslator.swift
//  CLALeakSample
//
//  Created by Yamada Shunya on 2019/11/14.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation

struct PostTranslator: AssociatedTranslator {
    typealias Entity = [PostEntity]
    typealias Model = [Post]
    
    func translate(_ entity: [PostEntity]) throws -> [Post] {
        return entity.map { Post($0) }
    }
}
