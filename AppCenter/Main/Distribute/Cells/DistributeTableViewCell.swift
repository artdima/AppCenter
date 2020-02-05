//
//  DistributeTableViewCell.swift
//  AppCenter
//
//  Created by Medyannik Dima on 25.01.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import UIKit

class DistributeTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "DistributeTableViewCell"
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    public var appRelease: AppsReleases? {
        didSet {
            guard let appRelease = appRelease else { return }
            let date = Date.getFormattedDate(string: appRelease.uploadedAt) ?? "-"
            self.idLabel.text = "\(appRelease.id)"
            self.descriptionLabel.text = "\(appRelease.shortVersion) (\(appRelease.version))"
            self.dateLabel.text = "\(date)"
            self.iconImage.image = UIImage(named: "box_icon")
        }
    }
}
