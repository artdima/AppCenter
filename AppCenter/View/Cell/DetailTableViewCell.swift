//
//  DetailTableViewCell.swift
//  AppCenter
//
//  Created by Medyannik Dmitri on 25.01.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "DetailTableViewCell"
    
    @IBOutlet weak var destinationsLabel: UILabel!
    @IBOutlet weak var downloadsLabel: UILabel!
    @IBOutlet weak var minimumOsLabel: UILabel!
    @IBOutlet weak var buildNumberLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var provisioningProfileLabel: UILabel!
    @IBOutlet weak var MD5FingerprintLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    

    public var appDetail: AppDetail? {
        didSet {
            guard let appDetail = appDetail else { return }
            let date = Date.getFormattedDate(string: appDetail.uploadedAt) ?? "-"
            self.destinationsLabel.text = "Groups: \(appDetail.destinations.first?.name ?? "–")"
            self.minimumOsLabel.text = "\(appDetail.appOs ?? "") \(appDetail.minOs ?? "")"
            self.buildNumberLabel.text = "\(appDetail.version)"
            let size = appDetail.size ?? 0
            self.sizeLabel.text = "\(sizeToMb(size: size))"
            self.provisioningProfileLabel.text = "\(appDetail.provisioningProfileName ?? "–")"
            self.MD5FingerprintLabel.text = "\(appDetail.fingerprint ?? "–")"
            self.versionLabel.text = "Version \(appDetail.shortVersion)"
            self.dateLabel.text = date
        }
    }
    
    //MARK: - IBAction
    @IBAction func installButtonTap(_ sender: UIButton) {
        guard let downloadUrl = appDetail?.downloadUrl, let url = URL(string: downloadUrl) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    private func sizeToMb(size: Int) -> String {
        guard size != 0 else { return "–" }
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useMB]
        bcf.countStyle = .file
        return bcf.string(fromByteCount: Int64(size))
    }
}
