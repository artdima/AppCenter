//
//  Constants.swift
//  AppCenter
//
//  Created by Medyannik Dima on 03.02.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import UIKit

let APP_VERSION = Bundle.main.releaseVersionNumber ?? "Unknown"
let BUILD_VERSION = Bundle.main.buildVersionNumber ?? "Not determinde"
let UUID = UIDevice.current.identifierForVendor?.uuidString ?? "Unknown"
let DEFAULT_CITY_NAME = "Москва"
let DEFAULT_SCODE = "appcenter"
let LATIТ_CHARS = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")

var DEVICE_WIDTH: CGFloat {
    return UIScreen.main.bounds.width
}

var DEVICE_HEIGHT: CGFloat {
    return UIScreen.main.bounds.height
}

var SAFE_AREA_BOTTOM_INSET: CGFloat {
    let window = UIApplication.shared.keyWindow
    return window?.safeAreaInsets.bottom ?? .leastNormalMagnitude
}

var SAFE_AREA_TOP_INSET: CGFloat {
    let window = UIApplication.shared.keyWindow
    return window?.safeAreaInsets.top ?? .leastNormalMagnitude
}
