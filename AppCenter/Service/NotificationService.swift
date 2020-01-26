//
//  NotificationService.swift
//  AppCenter
//
//  Created by Medyannik Dima on 25.01.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import Foundation
import SwiftMessages

fileprivate extension Theme {

    func backgroundColor() -> UIColor {
        switch self {
        case .success:
            return UIColor.colorWithHex("0x76CF67", alpha: 1)
        case .info:
            return UIColor.colorWithHex("0xBBBBBB", alpha: 1)
        case .warning:
            return UIColor.colorWithHex("0xDAC43C", alpha: 1)
        case .error:
            return UIColor.colorWithHex("0xDD3B41", alpha: 1)
        }
    }

}

final class NotificationService {
    
    static var shared = NotificationService()

    init() {
        //GSMessage.errorBackgroundColor = Theme.error.backgroundColor()
    }
    
    func showSuccessNotification(title: String, subtitle: String?) {
        showNotification(title: title, subtitle: subtitle, type: .success, callbackOnTap: nil)
    }
    
    func showInfoNotification(title: String, subtitle: String?, callbackOnTap callback: (() -> Void)? = nil) {
        showNotification(title: title, subtitle: subtitle, type: .info, callbackOnTap: callback)
    }
    
    func showWarningNotification(title: String, subtitle: String?) {
        showNotification(title: title, subtitle: subtitle, type: .warning, callbackOnTap: nil)
    }
    
    func showErrorNotification(title: String, subtitle: String?) {
        showNotification(title: title, subtitle: subtitle, type: .error, callbackOnTap: nil)
    }

    fileprivate func showNotification(title: String, subtitle: String?, type: Theme, callbackOnTap callback: (() -> Void)?) {
        let view = MessageView.viewFromNib(layout: .messageView)

        let backgroundColor = type.backgroundColor()
        let foregroundColor = UIColor.white

        let iconStyle = IconStyle.subtle
        let iconImage = iconStyle.image(theme: type)
        view.configureTheme(backgroundColor: backgroundColor, foregroundColor: foregroundColor, iconImage: iconImage)

        if let subtitle = subtitle {
            view.configureContent(title: title, body: subtitle)
        } else {
            view.configureContent(title: "", body: title)
        }

        view.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        view.bodyLabel?.font = UIFont.systemFont(ofSize: 15)

        view.button?.isHidden = true

        let id = view.id
        view.tapHandler = { _ in
            SwiftMessages.hide(id: id)
            callback?()
        }

        var config = SwiftMessages.defaultConfig
        config.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)

        SwiftMessages.show(config: config, view: view)
    }
    
    func topMostController() -> UIViewController {
        var topController = APP_DELEGATE.window!.rootViewController!
        while let presented = topController.presentedViewController {
            topController = presented
        }
        return topController
    }
    
}

