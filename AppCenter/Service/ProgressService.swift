//
//  ProgressService.swift
//  AppCenter
//
//  Created by Medyannik Dima on 25.01.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import Foundation
import SVProgressHUD

final class ProgressService {
    
    class func firstSetup() {
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setRingRadius(25)
        SVProgressHUD.setRingNoTextRadius(35)
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setBackgroundColor(UIColor(red: 33, green: 33, blue: 33, _alpha: 0.65))
        SVProgressHUD.setDefaultMaskType(.clear)
    }
    
    class func showLoadStatus() {
        SVProgressHUD.show(withStatus: "Загрузка...")
    }
    
    class func show(withStatus status: String!) {
        SVProgressHUD.show(withStatus: status)
    }
    
    class func dismiss() {
        SVProgressHUD.dismiss()
    }
    
}
