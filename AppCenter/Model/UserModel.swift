//
//  UserModel.swift
//  AppCenter
//
//  Created by Dmitriy Medyannik on 25.01.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import Foundation

struct User: Decodable {
    let id: String
    let displayName: String
    let email: String
    let name: String
    let avatarUrl: String?
    let canChangePassword: Bool?
    let createdAt: String
    let origin: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case displayName = "display_name"
        case email
        case name
        case avatarUrl = "avatar_url"
        case canChangePassword = "can_change_password"
        case createdAt = "created_at"
        case origin
    }

}
