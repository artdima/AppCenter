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

final class SetTokenViewController: UIViewController {
    
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
            .bind {
                guard let url = URL(string: "https://appcenter.ms/settings/apitokens") else { return }
                UIApplication.shared.open(url, options: [:], completionHandler: nil) //TODO: Change to WKWebView
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
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        self.tokenTextField.text = Defaults[\.token] ?? ""
    }
    
    private func updateSaveButton() {
        if let token = Defaults[\.token], tokenTextField.text ?? "" == token, !token.isEmpty {
            self.saveTokenButton.setupButton(color: .white, title: "Token saved 👍")
        } else {
            self.saveTokenButton.setupButton(color: .blue, title: "Save token")
        }
    }
    
}
