//
//  Router.swift
//  AppCenter
//
//  Created by Medyannik Dmitri on 25.01.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import UIKit

class Router {
    private weak var viewController: UIViewController?

    init(vc: UIViewController) {
        viewController = vc
    }

    func push(vc: UIViewController, animated: Bool = true) {
        viewController?.navigationController?.pushViewController(vc, animated: animated)
    }
    
    func push(tvc: UITableViewController, animated: Bool = true) {
        viewController?.navigationController?.pushViewController(tvc, animated: animated)
    }

    func present(vc: UIViewController) {
        vc.modalPresentationStyle = .fullScreen
        viewController?.present(vc, animated: true, completion: nil)
    }

    func presentAlert(tvc: UIViewController) {
        viewController?.present(tvc, animated: true, completion: nil)
    }
    
    func presentAlert(tvc: UITableViewController) {
        viewController?.present(tvc, animated: true, completion: nil)
    }

    func dismiss() {
        viewController?.dismiss(animated: true, completion: nil)
    }

    func popToRootViewController() {
        let _ = viewController?.navigationController?.popToRootViewController(animated: true)
    }

    func getViewControllersOfNav() -> [UIViewController]? {
        return viewController?.navigationController?.viewControllers
    }
}

extension Router {

    func setToken() {
        let vc = SetTokenViewController.Create()
        push(vc: vc)
    }
    
    func goSettings() {
        let tvc = SettingsTableViewController.Create()
        push(tvc: tvc)
    }
    
    func goHelp() {
        let storyboard = UIStoryboard(name: "Help", bundle: nil)
        let HelpVC = storyboard.instantiateInitialViewController() as? HelpVC
        push(vc: HelpVC!)
    }
}
