//
//  Extension + Bundle.swift
//  AppCenter
//
//  Created by Medyannik Dima on 05.02.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import Foundation

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
