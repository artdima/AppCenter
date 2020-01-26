//
//  Extension + UIColor.swift
//  AppCenter
//
//  Created by Medyannik Dima on 25.01.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init (red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }

    convenience init (red: CGFloat, green: CGFloat, blue: CGFloat, _alpha: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: _alpha)
    }

    class func colorWithHex(_ hex: String, alpha: CGFloat) -> UIColor {
        var rgbValue: uint = 0
        let hex = hex.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hex)

        scanner.scanHexInt32(&rgbValue)
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)
        let green = CGFloat((rgbValue & 0x00FF00) >> 8)
        let blue = CGFloat((rgbValue & 0x0000FF) >>  0)

        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}
