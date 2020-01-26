//
//  ViewController.swift
//  AppCenter
//
//  Created by Medyannik Dima on 25.01.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ChoiseAppViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var emptyTokenView: EmptyTokenView!
    
    // MARK: - internal
    internal var router: Router?
    
    let cellIdentifier = AppsCollectionViewCell.cellIdentifier
    let disposeBag = DisposeBag()
    private let viewModel = AppsViewModel()
    private var widthCell: Int {
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        return Int((screenWidth/2) - 18)
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let router = Router(vc: self)
        self.router = router
        
        start(empty: true)
        setupUI()
        
        UserDefaults.standard.rx
            .observe(String.self, "token")
            .subscribe(onNext: { [weak self] (value) in
                guard let strongSelf = self, let isEmpty = value?.isEmpty else { return }
                strongSelf.start(empty: isEmpty)
            })
            .disposed(by: disposeBag)
        
        emptyTokenView.setTokenButton.rx
            .tap
            .subscribe(onNext: { [weak self] in
                self?.router?.setToken()
            })
            .disposed(by: disposeBag)
        
        self.collectionView.register(UINib(nibName: "AppsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        bindViewModel()
    }
    
    private func setupUI() {
        self.navigationItem.title = "My Apps"
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    
    private func start(empty: Bool) {
        collectionView.isHidden = empty
        emptyTokenView.isHidden = !empty
    }
    
    //MARK: - IBAction
    @IBAction func settingsNavigationItemTap(_ sender: UINavigationItem) {
        router?.goSettings()
    }
    
}

extension ChoiseAppViewController {
    private func bindViewModel() {
        
        self.viewModel.output.apps
            .bind(to: collectionView.rx.items(cellIdentifier: cellIdentifier, cellType: AppsCollectionViewCell.self)) { [weak self] (index, data: Apps, cell) in
                guard let strongSelf = self else { return }
                cell.apps = data
                cell.widthCell = strongSelf.widthCell
            }
            .disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(Apps.self)
            .subscribe(onNext: { [unowned self] apps in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "DistributeViewController") as! DistributeViewController
                vc.apps = apps
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
