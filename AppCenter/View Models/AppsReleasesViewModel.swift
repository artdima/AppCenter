//
//  AppsReleasesViewModel.swift
//  AppCenter
//
//  Created by Dmitriy Medyannik on 25.01.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

struct AppsReleasesViewModel {
    let provider = MoyaProvider<AppCenter>(plugins: [NetworkLoggerPlugin(verbose: true)])
    let disposeBag = DisposeBag()
    
    let input: Input
    let output: Output

    struct Input {
        
    }

    struct Output {
        var apps = BehaviorRelay<[AppsReleases]>(value: [])
    }
    
    init(apps: Apps) {
        let finalResult = BehaviorRelay<[AppsReleases]>(value: [])
        
        provider.rx.request(.AppsReleases(owner_name: apps.owner.name, app_name: apps.name) ).subscribe {event in
            switch event {
            case .success(let response):
                let rezult: [AppsReleases] = try! JSONDecoder().decode([AppsReleases].self, from: response.data)
                finalResult.accept(rezult)
            case .error(let error):
                print("Unknown error: \(error)")
            }
        }.disposed(by: disposeBag)
        
        self.input = Input()
        self.output = Output(apps: finalResult)
    }
}

