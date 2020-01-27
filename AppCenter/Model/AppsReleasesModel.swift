//
//  AppsReleasesModel.swift
//  AppCenter
//
//  Created by Dmitriy Medyannik on 25.01.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import Foundation

struct AppsReleases: Decodable {
    let origin: String?
    let id: Int
    let shortVersion: String
    let version: String
    let uploadedAt: String
    let enabled: Bool
    let destinations: [Destinations]
    
    enum CodingKeys: String, CodingKey {
        case origin
        case id
        case shortVersion = "short_version"
        case version
        case uploadedAt = "uploaded_at"
        case enabled
        case destinations
    }
}

struct Destinations: Decodable {
    let id: String
    let name: String?
    let destination_type: DestinationType
    let display_name: String?
}

enum DestinationType: String, Decodable {
    case group, store, tester
}
