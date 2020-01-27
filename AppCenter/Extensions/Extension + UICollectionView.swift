//
//  Extension + UICollectionView.swift
//  AppCenter
//
//  Created by Medyannik Dmitri on 27.01.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import UIKit

extension UICollectionView {

    func registerNibForCell<T>(_ class: T) {
        var className = String(describing: T.self)
        className = String(className.dropLast(5)) // dropping ".Type"
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellWithReuseIdentifier: className)
    }

    func dequeueReusableCell<T>(_ class: T, for: IndexPath) -> UICollectionViewCell {
        return dequeueReusableCell(withReuseIdentifier: String(String(describing: T.self).dropLast(5)), for: `for`)
    }
}
