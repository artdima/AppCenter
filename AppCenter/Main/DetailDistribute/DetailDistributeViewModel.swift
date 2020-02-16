//
//  DetailDistributeViewModel.swift
//  AppCenter
//
//  Created by Medyannik Dima on 25.01.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

class DetailDistributeViewModel {
    let disposeBag = DisposeBag()
    var release = BehaviorRelay<[AppDetail]>.init(value: [])
    var apps = BehaviorRelay<Apps?>.init(value: nil)
    var appsRelease = BehaviorRelay<AppsReleases?>.init(value: nil)
    var title: String
    
    init(apps: Apps, appsRelease: AppsReleases) {
        self.apps.accept(apps)
        self.appsRelease.accept(appsRelease)
        self.title = "Release \(appsRelease.version)"
        let idRelease = String(describing: appsRelease.id)
        
        NetworkService.provider.rx
            .request(.AppDetail(owner_name: apps.owner.name, app_name: apps.name, release_id: idRelease))
            .subscribe { [weak self] event in
                switch event {
                case .success(let response):
                    let rezult: AppDetail = try! JSONDecoder().decode(AppDetail.self, from: response.data)
                    self?.release.accept([rezult])
                case .error(let error):
                    print("Unknown error: \(error)")
                }
            }.disposed(by: disposeBag)
        
//        NetworkService.provider.rx
//            .request(.AppDetail(owner_name: apps.owner.name, app_name: apps.name, release_id: idRelease))
//            .map(AppDetail.self)
//            .do(onError: { print("Unknown error \($0)") })
//            .map { [$0] }
//            .bind(to: release)
//            .disposed(by: disposeBag)
    }
}


