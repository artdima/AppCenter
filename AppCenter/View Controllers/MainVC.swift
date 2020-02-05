//
//  MainVC.swift
//  AppCenter
//
//  Created by Medyannik Dima on 05.02.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
    }

}
