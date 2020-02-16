//
//  DistributeViewModel.swift
//  AppCenter
//
//  Created by Dmitriy Medyannik on 25.01.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

class DistributeViewModel {
    let disposeBag = DisposeBag()
    let title: String
    
    var appsReleases = BehaviorRelay<[AppsReleases]>(value: [])
    var apps = BehaviorRelay<Apps?>(value: nil)
    let didSelect: PublishSubject<AppsReleases> = PublishSubject()
    let loading: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: true)
    
    init(apps: Apps) {
        self.apps.accept(apps)
        self.title = apps.displayName
        
        let resultAppReleases = NetworkService.provider.rx
            .request(.AppsReleases(owner_name: apps.owner.name, app_name: apps.name) )
            .asObservable()
        
        resultAppReleases
           .map { _ in false }
           .bind(to: loading)
           .disposed(by: disposeBag)
        
        resultAppReleases.subscribe {[weak self] response in
            if let data = response.event.element?.data {
                let rezult: [AppsReleases] = try! JSONDecoder().decode([AppsReleases].self, from: data)
                self?.appsReleases.accept(rezult)
            }
        }.disposed(by: disposeBag)
    }
}

