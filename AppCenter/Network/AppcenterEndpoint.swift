//
//  AppcenterEndpoint.swift
//  AppCenter
//
//  Created by Medyannik Dima on 25.01.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import Foundation
import Moya
import SwiftyUserDefaults

enum AppCenter {
    case UserGet
    case OrgsGet
    case AppsGet(token: String)
    case AppsReleases(owner_name: String, app_name: String)
    case AppDetail(owner_name: String, app_name: String, release_id: String)
}

extension AppCenter: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.appcenter.ms") else { fatalError("Base url not be configured.") }
        return url
    }
    
    var sampleData: Data {
        switch self {
        case .UserGet: return stubbedResponses("User")
        case .OrgsGet: return stubbedResponses("Orgs")
        case .AppsGet(_): return stubbedResponses("Apps")
        case .AppsReleases(_, _): return stubbedResponses("AppsReleases")
        case .AppDetail(_, _, _): return stubbedResponses("AppsReleases") //TODO: Change real data
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .UserGet: return .get
        case .OrgsGet: return .get
        case .AppsGet(_): return .get
        case .AppsReleases(_, _): return .get
        case .AppDetail(_, _, _): return .get
        }
    }
    
    var path: String {
        switch self {
        case .UserGet: return "/v0.1/user"
        case .OrgsGet: return "/v0.1/orgs"
        case .AppsGet(_): return "/v0.1/apps"
        case .AppsReleases(let owner_name, let app_name): return "/v0.1/apps/\(owner_name)/\(app_name)/releases"
        case .AppDetail(let owner_name, let app_name, let release_id): return "/v0.1/apps/\(owner_name)/\(app_name)/releases/\(release_id)"
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .AppsGet(let token): return ["accept": "application/json", "X-API-Token": token]
        default: return ["accept": "application/json", "X-API-Token": Defaults[\.token] ?? ""]
        }
    }
    
    var parameters: [String:AnyObject]? {
        return nil
    }
    
    var task: Task {
        return .requestParameters(parameters: [:], encoding: URLEncoding.default)
    }
    
//    public var validationType: ValidationType {
//      return .successCodes
//    }
    
}

//MARK: Get sample data from the JSON files
func stubbedResponses(_ fileName: String) -> Data! {
    @objc class TestClass: NSObject {}
    
    let bundle = Bundle(for: TestClass.self)
    let path = bundle.path(forResource: fileName, ofType: "json")
    return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
}
