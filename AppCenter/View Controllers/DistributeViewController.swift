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

class DistributeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
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
        
        setupUI()
        setupTableView()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let index = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    private func setupUI() {
       self.navigationItem.title = "Distribute"
       if #available(iOS 11.0, *) {
           self.navigationController?.navigationBar.prefersLargeTitles = true
       }
    }
    
    private func setupTableView() {
        self.tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.tableView.rowHeight = 50
    }
}

extension DistributeViewController {
    private func bindViewModel() {
        self.viewModel.output.apps
            .bind(to: tableView.rx.items(cellIdentifier: cellIdentifier, cellType: DistributeTableViewCell.self)) { (index, data: AppsReleases, cell) in
                cell.appRelease = data
            }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(AppsReleases.self)
            .subscribe(onNext: { (release: AppsReleases) in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailDistributeViewController") as! DetailDistributeViewController
                vc.appsRelease = release
                vc.apps = self.apps
                self.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: disposeBag)
    }
}
