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
    var viewWillAppear: PublishSubject<Bool> = PublishSubject<Bool>()
    
    //Output
    var apps: BehaviorSubject<[Apps]> = BehaviorSubject<[Apps]>(value: [])
    let loading: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
    let error: BehaviorSubject<Bool> = BehaviorSubject<Bool>(value: false)
    
    init() {
        let setToken = UserDefaults.standard.rx
            .observe(String.self, "token")
            .map { $0 ?? ""}
            .filter { !$0.isEmpty }
        
        setToken
            .debug()
            .map { _ -> [Apps] in return [] }
            .bind(to: apps)
            .disposed(by: disposeBag)
        
        
        let refresh = viewWillAppear.withLatestFrom(setToken)
        
        refresh
            .map { _ in true }
            .bind(to: loading)
            .disposed(by: disposeBag)
        
        let resultApp = refresh
            .flatMapLatest { token in
                NetworkService.provider.rx
                    .request(.AppsGet(token: token))
                    .asObservable()
            }
            //.share(replay: 1)
            
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
            .debug()
            .subscribe { [weak self] response in
                if response.event.element?.statusCode == 200, let data = response.event.element?.data {
                    let rezult: [Apps] = try! JSONDecoder().decode([Apps].self, from: data)
                    self?.apps.onNext(rezult) //accept(rezult)
                }
            }.disposed(by: disposeBag)
    }
}
