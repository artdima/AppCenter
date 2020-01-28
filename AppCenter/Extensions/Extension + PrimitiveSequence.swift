//
//  Extension + PrimitiveSequence.swift
//  AppCenter
//
//  Created by Medyannik Dmitri on 28.01.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

//extension PrimitiveSequence where TraitType == SingleTrait, ElementType == Response {
//    func catchAndShowErrors() -> Single<ElementType> {
//        return flatMap { response in
//            
//            guard (200...299).contains(response.statusCode) else {
//                if response.statusCode == 401 || response.statusCode == 403 {
//                    //User.saveAuthToken("")
//                }
//                do {
//                    let errorResponse = try response.map(Message.self, atKeyPath: "message")
//                    if let details = errorResponse.details {
//                        let _ = details.map {
//                            //ResponseError(code: $0.code, serverErrorText: errorResponse.text)
//                        }
//                        throw //ResponseError()
//                    } else {
//                        throw //ResponseError(code: nil, serverErrorText: errorResponse.text)
//                    }
//                } catch {
//                    throw error
//                }
//            }
//            return .just(response)
//        }
//    }
//}
