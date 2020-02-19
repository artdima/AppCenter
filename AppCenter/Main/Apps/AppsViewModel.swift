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
    //Input
    var viewWillAppear: PublishSubject<Void> = PublishSubject()
    
    //Output
    var apps: BehaviorRelay<[Apps]> = BehaviorRelay<[Apps]>(value: [])
    let loading: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
    let error: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
    
    init() {
        let setToken = UserDefaults.standard.rx
            .observe(String.self, "token")
            .map { $0 ?? ""}
            .filter { !$0.isEmpty }
        
        let refresh = Observable
            .merge(viewWillAppear.asObserver(),
                   setToken)
        
        setToken
            .map { _ in true }
            .bind(to: loading)
            .disposed(by: disposeBag)
        
        setToken
            .map { _ -> [Apps] in return [] }
            .bind(to: apps)
            .disposed(by: disposeBag)
        
        let resultApp = setToken
            .flatMapLatest { token in
                NetworkService.provider.rx
                    .request(.AppsGet(token: token))
                    .asObservable()
            }
            .share(replay: 1)
            
        resultApp
            .map { _ in false }
            .bind(to: loading)
            .disposed(by: disposeBag)
        
        resultApp
            .map{ result in
                return result.statusCode == 401
            }
            .debug()
            .bind(to: error)
            .disposed(by: disposeBag)
        
        
        resultApp
            .filter(statusCode: 200)
            .subscribe { [weak self] response in
                if let data = response.event.element?.data {
                    let rezult: [Apps] = try! JSONDecoder().decode([Apps].self, from: data)
                    self?.apps.accept(rezult)
                }
            }.disposed(by: disposeBag)
    }
}
