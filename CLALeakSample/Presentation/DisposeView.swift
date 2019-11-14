//
//  DisposeView.swift
//  CLALeakSample
//
//  Created by Yamada Shunya on 2019/11/14.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - Interface

protocol DisposeView: AnyObject {
    
}

// MARK: - Implementation

/// 問題なくDisposeされるViewController
final class DisposeViewController: BaseViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet private weak var timerLabel: UILabel!
    @IBOutlet private weak var startButton: UIButton!
    
    // MARK: Properties
    
    private var apiProvider: APIProvider!
    
    // MARK: Lifecycle
    
    func inject(apiProvider: APIProvider) {
        self.apiProvider = apiProvider
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        get()
    }
    
    deinit {
        print("\(type(of: self)) was deinit")
    }
}

extension DisposeViewController: DisposeView {
    
}

// MARK: - Setup

extension DisposeViewController {
    
    func setup() {
        // - Timer
        let timer = Observable<Int>
            .interval(.seconds(1), scheduler: MainScheduler.instance)
        // - Label
        timer.map { "\($0)" }
            .bind(to: timerLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func get() {
        apiProvider.get()
            .subscribe(onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
}
