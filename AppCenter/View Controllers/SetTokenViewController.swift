//
//  SetTokenViewController.swift
//  AppCenter
//
//  Created by Medyannik Dima on 25.01.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import UIKit
import PasswordTextField
import SwiftyUserDefaults

final class SetTokenViewController: UIViewController {
    
    @IBOutlet weak var backTextFieldView: UIView!
    @IBOutlet weak var tokenTextField: PasswordTextField!
    @IBOutlet weak var saveTokenButton: UIButton!
    
    // MARK: - internal
    internal var router: Router?
    
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
        self.saveTokenButton.sizeToFit()
    }
    
    private func updateSaveButton() {
        if let token = Defaults[\.token], !token.isEmpty {
            self.saveTokenButton.setTitle("Token saved 👍",for: .normal)
        } else {
            self.saveTokenButton.setTitle("Save",for: .normal)
        }
    }
    
    //MARK: - IBAction
    @IBAction func saveTokenTap(_ sender: UIButton) {
        Defaults[\.token] = tokenTextField.text
        updateSaveButton()
    }
    
    @IBAction func getTokenInAppCenter(_ sender: UIButton) {
        guard let url = URL(string: "https://appcenter.ms/settings/apitokens") else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
