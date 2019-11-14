//
//  APIProviderProtocol.swift
//  CLALeakSample
//
//  Created by Yamada Shunya on 2019/11/14.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation
import RxSwift

protocol APIProvider {
    func get() -> Observable<[PostEntity]>
}
