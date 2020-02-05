//
//  HelpListCollectionViewCell.swift
//  AppCenter
//
//  Created by Medyannik Dima on 05.02.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import UIKit

class HelpListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var separator: UIView! {
        didSet {
            separator.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
    }

    func bind(_ type: HelpViewModel.HelpType) {
        self.title.text = type.rawValue
        self.icon.image = type.image
    }
}
