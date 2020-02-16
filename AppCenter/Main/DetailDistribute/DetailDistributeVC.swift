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
        self.navigationItem.title = viewModel.title
    }
    
    private func bind() {
        self.viewModel.release
            .subscribeOn(MainScheduler.instance)
//            .catchError { [weak self] error -> Observable<[AppDetail]> in
//                //self?.showError(error as? ErrorResult) //TODO: showError
//                return Observable.just(nil)
//            }
            .bind(to: self.tableView.rx.items(cellIdentifier: cellIdentifier, cellType: DetailTableViewCell.self)) { (index, appDetail: AppDetail, cell) in
                cell.appDetail = appDetail
                cell.buttonInstall.rx.tap
                    .subscribe(onNext: {
                        guard let downloadUrl = appDetail.downloadUrl, let url = URL(string: downloadUrl) else { return }
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    })
                    .disposed(by: self.viewModel.disposeBag)
        }.disposed(by: self.viewModel.disposeBag)
    }

}
