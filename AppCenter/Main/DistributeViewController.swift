//
//  DistributeViewController.swift
//  AppCenter
//
//  Created by Dmitriy Medyannik on 25.01.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DistributeViewController: MainVC {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerNibForCell(DistributeTableViewCell.self)
            tableView.rowHeight = 50
        }
    }
    
    // MARK: - internal
    internal var router: Router?
    
    let disposeBag = DisposeBag()
    var apps: Apps?
    let cellIdentifier = DistributeTableViewCell.cellIdentifier
    private var viewModel: AppsReleasesViewModel!
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let router = Router(vc: self)
        self.router = router
        
        if let apps = apps {
            viewModel = AppsReleasesViewModel(apps: apps)
        }
        
        prepare()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let index = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    private func prepare() {
       self.navigationItem.title = "Distribute"
    }
}

extension DistributeViewController {
    private func bindViewModel() {
        self.viewModel.output.apps
            .bind(to: tableView.rx.items(cellIdentifier: cellIdentifier, cellType: DistributeTableViewCell.self)) { (index, data: AppsReleases, cell) in
                cell.appRelease = data
            }.disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(AppsReleases.self)
            .subscribe(onNext: { (release: AppsReleases) in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailDistributeViewController") as! DetailDistributeViewController
                vc.appsRelease = release
                vc.apps = self.apps
                self.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: disposeBag)
    }
}
