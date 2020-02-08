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

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerNibForCell(DistributeTableViewCell.self)
            tableView.rowHeight = 50
        }
    }
    
    // MARK: - Private properties
    private let cellIdentifier = DistributeTableViewCell.cellIdentifier
    
    // MARK: - Public properties
    var viewModel: DistributeViewModel!
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepare()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let index = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    // MARK: - Private methods
    private func prepare() {
        self.navigationItem.title = viewModel.title
    }
}

extension DistributeViewController {
    private func bind() {
        self.viewModel.appsReleases
            .bind(to: tableView.rx.items(cellIdentifier: cellIdentifier, cellType: DistributeTableViewCell.self)) { (index, data: AppsReleases, cell) in
                cell.appRelease = data
            }.disposed(by: viewModel.disposeBag)
        
        tableView.rx
            .modelSelected(AppsReleases.self)
            .subscribe(onNext: { [weak self] (release: AppsReleases) in
                guard let self = self else { return }
                Router.detailDistribute(apps: self.viewModel?.apps.value, appsRelease: release).push(from: self.navigationController)
            }).disposed(by: viewModel.disposeBag)
    }
}
