//
//  DetailDistributeViewController.swift
//  AppCenter
//
//  Created by Medyannik Dima on 25.01.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailDistributeViewController: MainVC {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerNibForCell(DetailTableViewCell.self)
            tableView.rowHeight = 490
            tableView.separatorStyle = .none
        }
    }
    
    let cellIdentifier = DetailTableViewCell.cellIdentifier
    var viewModel: DetailDistributeViewModel!
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepare()
        bind()
    }
    
    private func prepare() {
    }
    
    private func bind() {
        self.viewModel.appsRelease
            .subscribe(onNext: { [weak self] appsRelease in
                guard let self = self, let version = appsRelease?.version else { return }
                self.navigationItem.title = "Release \(version)"
            }).disposed(by: self.viewModel.disposeBag)
        
        self.viewModel.release
            .subscribeOn(MainScheduler.instance)
//            .catchError { [weak self] error -> Observable<[AppDetail]> in
//                //self?.showError(error as? ErrorResult) //TODO: showError
//                return Observable.just(nil)
//            }
            .bind(to: self.tableView.rx.items(cellIdentifier: cellIdentifier, cellType: DetailTableViewCell.self)) { (index, appDetail: AppDetail, cell) in
                cell.appDetail = appDetail
        }.disposed(by: self.viewModel.disposeBag)
    }

}
