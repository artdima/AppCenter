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

class DetailDistributeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerNibForCell(DetailTableViewCell.self)
            tableView.rowHeight = 490
            tableView.separatorStyle = .none
        }
    }
    
    // MARK: - internal
    internal var router: Router?
    
    let disposeBag = DisposeBag()
    var apps: Apps?
    var appsRelease: AppsReleases?
    let cellIdentifier = DetailTableViewCell.cellIdentifier
    
    private var viewModel: AppDetailViewModel!
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let router = Router(vc: self)
        
        if let appsRelease = appsRelease, let apps = apps {
            viewModel = AppDetailViewModel(apps: apps, appsRelease: appsRelease)
        }
        self.router = router
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        guard let appsRelease = appsRelease else { return }
        self.navigationItem.title = "Release \(appsRelease.version)"
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
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
