//
//  HelpViewModel.swift
//  AppCenter
//
//  Created by Medyannik Dima on 05.02.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class HelpViewModel {
    let bag = DisposeBag()
    let contentType = BehaviorRelay<HelpType?>.init(value: nil)
    let sections = BehaviorRelay<[SectionModel]>.init(value: [])
    
    enum HelpType: String {
        case docs =  "Docs & APIs"
        case roadmap =  "Roadmap"
        case system = "System status"
        case top = "Top feature requests"
        case submit = "Submit feature request"
        
        static let allItems = [system, docs, roadmap, top, submit]
        
        var image: UIImage? {
            switch self {
            case .docs: return UIImage(named: "docs")
            case .roadmap: return UIImage(named: "roadmap")
            case .system: return UIImage(named: "system")
            case .top: return UIImage(named: "top")
            case .submit: return UIImage(named: "submit")
            }
        }
        
        var urlAddress: String {
            switch self {
            case .docs: return "https://aka.ms/appcenterdocs"
            case .roadmap: return "https://github.com/Microsoft/appcenter/wiki/Roadmap"
            case .system: return "https://status.appcenter.ms/"
            case .top: return "https://github.com/Microsoft/appcenter/issues?utf8=✓&q=is%3Aissue+is%3Aopen+sort%3Areactions-%2B1-desc+label%3A%22feature+request%22+"
            case .submit: return "https://github.com/Microsoft/appcenter/issues/new?assignees=&labels=feature+request&template=feature_request.md&title="
            }
        }
    }
}

extension HelpViewModel {
     enum SectionModel: AnimatableSectionModelType {
           case section(items: [Item])
           
           typealias Item = ItemModel
           typealias Identity = String
           
           var items: [Item] {
               switch self {
               case .section(let items): return items.map { $0 }
               }
           }
           
           init(original: SectionModel, items: [Item]) {
               switch original {
               case .section: self = .section(items: items)
               }
           }
           
           var identity: Identity {
               switch self {
               case .section: return "section"
               }
           }
       }
       
       enum ItemModel: Equatable, IdentifiableType {
           case helpItem(_ name: HelpType)
           
           typealias Identity = String
                  
                  var identity: Identity {
                       switch self {
                       case .helpItem(let type): return "helpItem" + type.rawValue
                       }
                   }
           
           static func ==(lhs: ItemModel, rhs: ItemModel) -> Bool {
               return lhs.identity == rhs.identity
           }
       }
       
       func generateSection() -> [SectionModel] {
           var items: [ItemModel] = []
           items = HelpType.allItems.map { .helpItem($0) }
           return [.section(items: items)]
       }
}
