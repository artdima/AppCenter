//
//  SetTokenViewController.swift
//  AppCenter
//
//  Created by Medyannik Dima on 25.01.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import PasswordTextField
import SwiftyUserDefaults
import SafariServices

final class SetTokenViewController: MainVC {
    
    @IBOutlet weak var backTextFieldView: UIView!
    @IBOutlet weak var tokenTextField: PasswordTextField!
    @IBOutlet weak var saveTokenButton: MainButton!
    @IBOutlet weak var getTokenInAppCenter: UIButton!
    
    // MARK: - internal
    internal var router: Router?
    
    let disposeBag = DisposeBag()
    
    static func Create() -> UIViewController {
        let storyboard = UIStoryboard(name: "SetToken", bundle: nil)
        let setTokenViewController = storyboard.instantiateInitialViewController() as? SetTokenViewController
        return setTokenViewController!
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let router = Router(vc: self)
        self.router = router
        
        setupUI()
        updateSaveButton()
        
        //Tap: Save token
        saveTokenButton.rx.tap
            .bind { [weak self] in
                guard let strongSelf = self else { return }
                Defaults[\.token] = strongSelf.tokenTextField.text
                strongSelf.updateSaveButton()
            }.disposed(by: disposeBag)
        
        //Tap: Get Token In AppCenter
        getTokenInAppCenter.rx.tap
            .bind { [weak self] in
                self?.showSafariPopover("https://appcenter.ms/settings/apitokens")
            }.disposed(by: disposeBag)
        
        //Change: tokenTextField
        tokenTextField.rx.text.bind{ [weak self] _ in
            self?.updateSaveButton()
        }.disposed(by: disposeBag)
    }
    
    private func setupUI() {
        self.navigationItem.title = "Set token"
        self.view.backgroundColor = UIColor.colorWithHex("0xf0f0f0", alpha: 1)
        self.backTextFieldView.layer.cornerRadius = 4
        self.backTextFieldView.clipsToBounds = false
        self.tokenTextField.text = Defaults[\.token] ?? ""
    }
    
    private func updateSaveButton() {
        if let token = Defaults[\.token], tokenTextField.text ?? "" == token, !token.isEmpty {
            self.saveTokenButton.setupButton(color: .white, title: "Token saved 👍")
        } else {
            self.saveTokenButton.setupButton(color: .blue, title: "Save token")
        }
    }
    
    private func showSafariPopover(_ address: String) {
        guard let URLFromString = URL(string: address) else { return }
        let safariVC = SFSafariViewController(url: URLFromString)
        safariVC.modalPresentationStyle = .popover
        self.present(safariVC, animated: true, completion: nil)
    }
    
}
