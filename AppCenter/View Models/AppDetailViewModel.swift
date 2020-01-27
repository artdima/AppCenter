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

class AppDetailViewModel {
    let provider = MoyaProvider<AppCenter>(plugins: [NetworkLoggerPlugin(verbose: true)])
    let disposeBag = DisposeBag()
    var release = BehaviorRelay<[AppDetail]>.init(value: [])
    
    init(apps: Apps, appsRelease: AppsReleases) {
        
        let idRelease = String(describing: appsRelease.id)
        provider.rx.request(.AppDetail(owner_name: apps.owner.name, app_name: apps.name, release_id: idRelease)).subscribe { [weak self] event in
            switch event {
            case .success(let response):
                let rezult: AppDetail = try! JSONDecoder().decode(AppDetail.self, from: response.data)
                self?.release.accept([rezult])
            case .error(let error):
                print("Unknown error: \(error)")
            }
        }.disposed(by: disposeBag)
    }
}


