//
//  SettingsViewController.swift
//  AppCenter
//
//  Created by Medyannik Dima on 25.01.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var titleToken: UILabel!
    
    // MARK: - internal
    internal var router: Router?
    
    let disposeBag = DisposeBag()
    
    static func Create() -> UITableViewController {
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        let settingsTableViewController = storyboard.instantiateInitialViewController() as? SettingsTableViewController
        return settingsTableViewController!
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let router = Router(vc: self)
        self.router = router
        
        setupUI()
        
        UserDefaults.standard.rx
        .observe(String.self, "token")
        .subscribe(onNext: { [weak self] (value) in
            guard let strongSelf = self, let isEmpty = value?.isEmpty else { return }
            let set = isEmpty ? "" : "    •••••••"
            strongSelf.titleToken.text = "API token \(set)"
        })
        .disposed(by: disposeBag)
    }
    
    private func setupUI() {
        self.navigationItem.title = "Settings"
        self.tableView.backgroundColor = UIColor.colorWithHex("0xf0f0f0", alpha: 1)
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        self.avatarImage.layer.cornerRadius = self.avatarImage.frame.height / 2
        self.avatarImage.layer.borderColor = UIColor.white.cgColor
        self.avatarImage.layer.borderWidth = 5
    }
}

extension SettingsTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            tableView.deselectRow(at: indexPath, animated: true)
            router?.setToken()
        }
    }
}
