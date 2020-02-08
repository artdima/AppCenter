//
//  HelpVC.swift
//  AppCenter
//
//  Created by Medyannik Dima on 05.02.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SafariServices

class HelpVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.registerNibForCell(HelpListCollectionViewCell.self)
        }
    }
    
    //MARK: - Properties
    let viewModel = HelpViewModel()
    typealias Section = HelpViewModel.SectionModel
    typealias Item = HelpViewModel.ItemModel
    var helpDataSource: RxCollectionViewSectionedAnimatedDataSource<Section>!
    
    //MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Help"
        prepare()
        subscribe()
    }
    
    //MARK: - Private methods
    private func prepare() {
        helpDataSource = generateSectionDataSource()
        collectionView.rx
            .setDelegate(self)
            .disposed(by: viewModel.bag)
        viewModel.sections.accept(viewModel.generateSection())
    }
    
    private func subscribe() {
        viewModel.sections
            .asObservable()
            .bind(to: collectionView.rx.items(dataSource: helpDataSource))
            .disposed(by: viewModel.bag)
        
        collectionView.rx
            .modelSelected(Item.self)
            .subscribe(onNext: { (item: Item) in
                if case .helpItem(let type) = item {
                    self.showSafariPopover(type.urlAddress)
                }
        }).disposed(by: viewModel.bag)
    }
    
    private func showSafariPopover(_ address: String) {
       guard let URLFromString = URL(string: address) else { return }
       let safariVC = SFSafariViewController(url: URLFromString)
       safariVC.modalPresentationStyle = .popover
       self.present(safariVC, animated: true, completion: nil)
   }
}

//MARK: - CollectionViewDelegate
extension HelpVC: UICollectionViewDelegateFlowLayout {
    private func generateSectionDataSource() -> RxCollectionViewSectionedAnimatedDataSource<Section> {
        return RxCollectionViewSectionedAnimatedDataSource<Section>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .fade, reloadAnimation: .fade, deleteAnimation: .fade),
            configureCell: { dataSource, collectionView, indexPath, _ in

                let item: Item = self.helpDataSource[indexPath]

                switch item {
                case .helpItem(let type):
                    let cell = collectionView.dequeueReusableCell(HelpListCollectionViewCell.self, for: indexPath) as! HelpListCollectionViewCell
                    cell.bind(type)
                    return cell
                }
        },
            configureSupplementaryView: { _, _, _, _ in
                return UICollectionReusableView()
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = DEVICE_WIDTH - 16
        return CGSize(width: cellWidth, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 24, right: 0)
    }
}
