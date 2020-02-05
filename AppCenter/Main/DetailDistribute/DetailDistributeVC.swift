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
    
    let disposeBag = DisposeBag()
    var apps: Apps?
    var appsRelease: AppsReleases?
    let cellIdentifier = DetailTableViewCell.cellIdentifier
    
    private var viewModel: DetailDistributeViewModel!
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let appsRelease = appsRelease, let apps = apps {
            viewModel = DetailDistributeViewModel(apps: apps, appsRelease: appsRelease)
        }
        
        prepare()
        bindViewModel()
    }
    
    private func prepare() {
        guard let appsRelease = appsRelease else { return }
        self.navigationItem.title = "Release \(appsRelease.version)"
    }
    
    private func bindViewModel() {
        self.viewModel.release
            .subscribeOn(MainScheduler.instance)
//            .catchError { [weak self] error -> Observable<[AppDetail]> in
//                //self?.showError(error as? ErrorResult) //TODO: showError
//                return Observable.just(nil)
//            }
            .bind(to: self.tableView.rx.items(cellIdentifier: cellIdentifier, cellType: DetailTableViewCell.self)) { (index, appDetail: AppDetail, cell) in
                cell.appDetail = appDetail
        }.disposed(by: disposeBag)
    }

}
