//
//  Extension + UITableView.swift
//  AppCenter
//
//  Created by Medyannik Dmitri on 27.01.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import UIKit

extension UITableView {
    func registerNibForCell<T>(_ class: T) {
        var className = String(describing: T.self)
        className = String(className.dropLast(5)) // dropping ".Type"
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellReuseIdentifier: className)
    }
}
