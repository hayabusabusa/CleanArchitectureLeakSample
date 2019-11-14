//
//  SingletonAPIProvider.swift
//  CLALeakSample
//
//  Created by Yamada Shunya on 2019/11/14.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import Foundation
import RxSwift

final class SingletoneAPIProvider: APIProvider {
    
    // MARK: Singleton
    
    static let shared: SingletoneAPIProvider = SingletoneAPIProvider()
    
    // MARK: Properties
    
    private let baseURL: String = "https://jsonplaceholder.typicode.com/posts"
    private let session: URLSession = URLSession.shared
    
    // MARK: Initializer
    
    private init() {}
    
    // MARK: API
    
    /// `/posts` にGETのリクエストを送る
    ///
    /// - Note:
    /// Observableの挙動を見たいのであえてcompletedを流さない
    func get() -> Observable<[PostEntity]> {
        return Observable.create { observer in
            if let url = URL(string: self.baseURL) {
                self.session.dataTask(with: url) { (data, response, error) in
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
