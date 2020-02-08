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
    
    let title = "My Apps"
    let disposeBag = DisposeBag()
    
    //Output
    var apps = BehaviorRelay<[Apps]>(value: [])
    
    init() {
        UserDefaults.standard.rx
            .observe(String.self, "token")
            .map { $0 ?? ""}
            .filter { !$0.isEmpty }
            .flatMapLatest { token in
                NetworkService.provider.rx.request(.AppsGet(token: token))
            }
            .filter(statusCode: 200)
            .subscribe { [weak self] response in
                if let data = response.event.element?.data {
                    let rezult: [Apps] = try! JSONDecoder().decode([Apps].self, from: data)
                    self?.apps.accept(rezult)
                }
            }.disposed(by: disposeBag)
    }
}
