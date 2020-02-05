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
        
        prepare()
        subscribe()
    }
    
    //MARK: - Function
    private func prepare() {
        self.navigationItem.title = "Settings"
        self.tableView.backgroundColor = UIColor.colorWithHex("0xf0f0f0", alpha: 1)
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        self.avatarImage.layer.cornerRadius = self.avatarImage.frame.height / 2
        self.avatarImage.layer.borderColor = UIColor.white.cgColor
        self.avatarImage.layer.borderWidth = 5
    }
    
    private func subscribe() {
        //Event: Set token
        UserDefaults.standard.rx
            .observe(String.self, "token")
            .subscribe(onNext: { [weak self] (value) in
                guard let strongSelf = self, let isEmpty = value?.isEmpty else { return }
                let set = isEmpty ? "" : "    •••••••"
                strongSelf.titleToken.text = "API token \(set)"
            })
            .disposed(by: disposeBag)
        
        //Event: Select row
        tableView.rx
            .itemSelected
            .bind { [weak self] indexPath in
                if indexPath.section == 0, let strongSelf = self {
                    strongSelf.tableView.deselectRow(at: indexPath, animated: true)
                    strongSelf.router?.setToken()
                }
            }.disposed(by: disposeBag)
    }
}
