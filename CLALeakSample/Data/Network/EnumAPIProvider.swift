//
//  EnumAPIProvider.swift
//  CLALeakSample
//
//  Created by Yamada Shunya on 2019/11/14.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation
import RxSwift

enum EnumAPIProvider {
    
    // MARK: Properties
    
    private static let baseURL: String = "https://jsonplaceholder.typicode.com/posts"
    
    // MARK: API
    
    static func get() -> Observable<[PostEntity]> {
        return Observable.create { observer in
            if let url = URL(string: self.baseURL) {
                URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let error = error {
                        observer.on(.error(error))
                    }
                    if let data = data {
                        do {
                            let posts = try JSONDecoder().decode([PostEntity].self, from: data)
                            observer.on(.next(posts))
                        } catch {
                            observer.on(.error(error))
                        }
                    } else {
                        observer.on(.next([]))
                    }
                }.resume()
            }
            return Disposables.create {
                print("\(type(of: self)).get().Observable was disposed.")
            }
        }
    }
}
