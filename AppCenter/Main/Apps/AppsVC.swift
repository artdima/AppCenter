//
//  AppsViewController.swift
//  AppCenter
//
//  Created by Medyannik Dima on 25.01.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AppsViewController: MainVC {
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.registerNibForCell(AppsCollectionViewCell.self)
        }
    }
    @IBOutlet weak var emptyTokenView: EmptyTokenView!
    @IBOutlet weak var settingsBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var helpBarButton: UIBarButtonItem!
    
    // MARK: - Private properties
    private let cellIdentifier = AppsCollectionViewCell.cellIdentifier
    private let viewModel = AppsViewModel()
    private var widthCell: Int {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        return Int((screenWidth/2) - 18)
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepare()
        subscribe()
        bindViewModel()
    }
    
    // MARK: - Private methods
    private func prepare() {
        self.navigationItem.title = viewModel.title
    }
    
    private func subscribe() {
        //Event: Set token
        UserDefaults.standard.rx
            .observe(String.self, "token")
            .subscribe(onNext: { [weak self] (value) in
                guard let strongSelf = self, let isEmpty = value?.isEmpty else { return }
                strongSelf.collectionView.isHidden = isEmpty
                strongSelf.emptyTokenView.isHidden = !isEmpty
            })
            .disposed(by: self.viewModel.disposeBag)
        
        //Tap: Set token
        emptyTokenView.setTokenButton.rx
            .tap
            .subscribe(onNext: { [weak self] in
                Router.setToken.push(from: self?.navigationController)
            })
            .disposed(by: self.viewModel.disposeBag)
        
        //Tap: Settings
        settingsBarButtonItem.rx
            .tap
            .bind { [weak self] in
                Router.settings.push(from: self?.navigationController)
            }.disposed(by: self.viewModel.disposeBag)
        
        helpBarButton.rx
            .tap
            .subscribe(onNext: { [weak self] in
                Router.help.push(from: self?.navigationController)
            })
            .disposed(by: self.viewModel.disposeBag)
    }
}

extension AppsViewController {
    private func bindViewModel() {
        
        self.viewModel.apps
            .bind(to: collectionView.rx.items(cellIdentifier: cellIdentifier, cellType: AppsCollectionViewCell.self)) { [weak self] (index, data: Apps, cell) in
                guard let strongSelf = self else { return }
                cell.apps = data
                cell.widthCell = strongSelf.widthCell
            }
            .disposed(by: self.viewModel.disposeBag)
        
        collectionView.rx
            .modelSelected(Apps.self)
            .subscribe(onNext: { [unowned self] apps in
                Router.distribute(apps: apps).push(from: self.navigationController)
            })
            .disposed(by: self.viewModel.disposeBag)
    }
}
