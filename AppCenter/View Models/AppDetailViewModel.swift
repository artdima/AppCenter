//
//  AppDetailViewModel.swift
//  AppCenter
//
//  Created by Medyannik Dima on 25.01.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

struct AppDetailViewModel {
    let provider = MoyaProvider<AppCenter>(plugins: [NetworkLoggerPlugin(verbose: true)])
    let disposeBag = DisposeBag()
    
    let input: Input
    let output: Output

    struct Input {
        
    }

    struct Output {
        var release = BehaviorRelay<[AppDetail]>(value: [])
    }
    
    init(apps: Apps, appsRelease: AppsReleases) {
        let finalResult = BehaviorRelay<[AppDetail]>(value: [])
        let idRelease = String(describing: appsRelease.id)
        provider.rx.request(.AppDetail(owner_name: apps.owner.name, app_name: apps.name, release_id: idRelease)).subscribe {event in
            switch event {
            case .success(let response):
                let rezult: AppDetail = try! JSONDecoder().decode(AppDetail.self, from: response.data)
                var resultArr: [AppDetail] = []
                resultArr.append(rezult)
                finalResult.accept(resultArr)
            case .error(let error):
                print("Unknown error: \(error)")
            }
        }.disposed(by: disposeBag)
        
        self.input = Input()
        self.output = Output(release: finalResult)
    }
}


