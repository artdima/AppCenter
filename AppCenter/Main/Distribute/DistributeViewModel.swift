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
    
    var appsReleases = BehaviorRelay<[AppsReleases]>(value: [])
    var apps = BehaviorRelay<Apps?>(value: nil)
    
    init(apps: Apps) {
        self.apps.accept(apps)
        
        NetworkService.provider.rx
            .request(.AppsReleases(owner_name: apps.owner.name, app_name: apps.name) )
            .subscribe {[weak self] event in
            switch event {
            case .success(let response):
                let rezult: [AppsReleases] = try! JSONDecoder().decode([AppsReleases].self, from: response.data)
                self?.appsReleases.accept(rezult)
            case .error(let error):
                print("Unknown error: \(error)")
            }
        }.disposed(by: disposeBag)
    }
}

