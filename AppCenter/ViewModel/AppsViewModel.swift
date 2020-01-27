//
//  AppsViewModel.swift
//  AppCenter
//
//  Created by Medyannik Dima on 25.01.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
import SwiftyUserDefaults

class AppsViewModel {
    
    private let disposeBag = DisposeBag()
    
    let input: Input
    let output: Output

    struct Input {
        
    }

    struct Output {
        var apps = BehaviorRelay<[Apps]>(value: [])
    }
    
    init() {
        let finalResult = BehaviorRelay<[Apps]>(value: [])
        let provider = MoyaProvider<NetworkService>(plugins: [NetworkLoggerPlugin(verbose: true)])
        
        UserDefaults.standard.rx
            .observe(String.self, "token")
            .map { $0 ?? ""}
            .filter { !$0.isEmpty }
            .flatMapLatest { token in
                provider.rx.request(.AppsGet(token: token))
            }
            .filter(statusCode: 200)
            .subscribe { response in
                if let data = response.event.element?.data {
                    let rezult: [Apps] = try! JSONDecoder().decode([Apps].self, from: data)
                    finalResult.accept(rezult)
                }
            }.disposed(by: disposeBag)
        
        self.input = Input()
        self.output = Output(apps: finalResult)
    }
}
