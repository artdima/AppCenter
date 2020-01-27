//
//  AppsModel.swift
//  AppCenter
//
//  Created by Dmitriy Medyannik on 25.01.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import Foundation

struct Apps: Decodable {
    let id: String
    let appSecret: String
    let description: String?
    let displayName: String
    let name: String
    let os: String
    let platform: String
    let origin: String
    let iconUrl: String
    let createdAt: String
    let updatedAt: String
    let releaseType: String
    let owner: Owner
    let azureSubscription: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case appSecret = "app_secret"
        case description
        case displayName = "display_name"
        case name
        case os
        case platform
        case origin
        case iconUrl = "icon_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case releaseType = "release_type"
        case owner
        case azureSubscription = "azure_subscription"
    }
}

struct Owner: Decodable {
    let id: String
    let avatar_url: String?
    let display_name: String
    let email: String?
    let name: String
    let type: String
}
