//
//  AppDetailModel.swift
//  AppCenter
//
//  Created by Medyannik Dima on 25.01.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import Foundation

struct AppDetail: Decodable {
    let id: Int
    let appName: String
    let appDisplayName: String
    let appOs: String?
    let version: String
    let shortVersion: String
    let releaseNotes: String?
    let provisioningProfileName: String?
    let provisioningProfileExpiryDate: String?
    let isProvisioningProfileSyncing: Bool?
    let size: Int?
    let minOs: String?
    let deviceFamily: String?
    let androidMinApiLevel: String?
    let bundleIdentifier: String?
    let packageHashes: [String]?
    let fingerprint: String?
    let uploadedAt: String
    let downloadUrl: String?
    let appIconUrl: String
    let installUrl: String?
    let distributionGroups: [DistributionGroups]?
    let distributionStores: [DistributionStores]?
    let destinations: [Destinations]
    let isUdidProvisioned: Bool?
    let canResign: Bool?
    let build: Build?
    let enabled: Bool
    let status: String?
    let isExternalBuild: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case appName = "app_name"
        case appDisplayName = "app_display_name"
        case appOs = "app_os"
        case version
        case shortVersion = "short_version"
        case releaseNotes = "release_notes"
        case provisioningProfileName = "provisioning_profile_name"
        case provisioningProfileExpiryDate = "provisioning_profile_expiry_date"
        case isProvisioningProfileSyncing = "is_provisioning_profile_syncing"
        case size
        case minOs = "min_os"
        case deviceFamily = "device_family"
        case androidMinApiLevel = "android_min_api_level"
        case bundleIdentifier = "bundle_identifier"
        case packageHashes = "package_hashes"
        case fingerprint
        case uploadedAt = "uploaded_at"
        case downloadUrl = "download_url"
        case appIconUrl = "app_icon_url"
        case installUrl = "install_url"
        case distributionGroups = "distribution_groups"
        case distributionStores = "distribution_stores"
        case destinations
        case isUdidProvisioned = "is_udid_provisioned"
        case canResign = "can_resign"
        case build
        case enabled
        case status
        case isExternalBuild = "is_external_build"
    }
}

struct DistributionGroups: Decodable {
    let id: String
    let name: String
}

struct DistributionStores: Decodable {
    let id: String
    let name: String
    let publishing_status: String
}

struct Build: Decodable {
    let branch_name: String
    let commit_hash: String
    let commit_message: String
}
 
