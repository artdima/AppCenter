//
//  MainButton.swift
//  AppCenter
//
//  Created by Medyannik Dima on 25.01.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import UIKit

@IBDesignable
class MainButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = frame.size.height / 2
        layer.borderColor = #colorLiteral(red: 0.2549019608, green: 0.6117647059, blue: 1, alpha: 1)
        layer.borderWidth = 2
    }
}
