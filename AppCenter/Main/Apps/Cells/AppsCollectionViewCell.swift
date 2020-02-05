//
//  AppsCollectionViewCell.swift
//  AppCenter
//
//  Created by Dmitriy Medyannik on 25.01.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import UIKit
import SDWebImage

class AppsCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "AppsCollectionViewCell"
    
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var ownerDisplayNameLabel: UILabel!
    @IBOutlet weak var widthCellConstraint: NSLayoutConstraint!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var backView: UIView!

    public var apps: Apps? {
        didSet {
            guard let apps = apps else { return }
            self.displayNameLabel.text = apps.displayName
            self.iconImage.sd_setImage(with: URL(string: apps.iconUrl))
            self.iconImage.layer.cornerRadius = 20
            self.iconImage.clipsToBounds = true
        }
    }
    public var widthCell: Int! {
        didSet {
            widthCellConstraint.constant = CGFloat(widthCell - 24)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10
        layer.borderColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        layer.borderWidth = 1
    }
}
