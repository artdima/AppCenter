//
//  Router.swift
//  AppCenter
//
//  Created by Medyannik Dmitri on 25.01.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import UIKit

//class Router {
//    private weak var viewController: UIViewController?
//
//    init(vc: UIViewController) {
//        viewController = vc
//    }
//
//    func push(vc: UIViewController, animated: Bool = true) {
//        viewController?.navigationController?.pushViewController(vc, animated: animated)
//    }
//
//    func push(tvc: UITableViewController, animated: Bool = true) {
//        viewController?.navigationController?.pushViewController(tvc, animated: animated)
//    }
//
//    func present(vc: UIViewController) {
//        vc.modalPresentationStyle = .fullScreen
//        viewController?.present(vc, animated: true, completion: nil)
//    }
//
//    func presentAlert(tvc: UIViewController) {
//        viewController?.present(tvc, animated: true, completion: nil)
//    }
//
//    func presentAlert(tvc: UITableViewController) {
//        viewController?.present(tvc, animated: true, completion: nil)
//    }
//
//    func dismiss() {
//        viewController?.dismiss(animated: true, completion: nil)
//    }
//
//    func popToRootViewController() {
//        let _ = viewController?.navigationController?.popToRootViewController(animated: true)
//    }
//
//    func getViewControllersOfNav() -> [UIViewController]? {
//        return viewController?.navigationController?.viewControllers
//    }
//}
//
//extension Router {
//
//    func setToken() {
//        let vc = SetTokenViewController.Create()
//        push(vc: vc)
//    }
//
//    func goSettings() {
//        let tvc = SettingsTableViewController.Create()
//        push(tvc: tvc)
//    }
//
//    func goHelp() {
//        let storyboard = UIStoryboard(name: "Help", bundle: nil)
//        let HelpVC = storyboard.instantiateInitialViewController() as? HelpVC
//        push(vc: HelpVC!)
//    }
//}


//enum SourceScreen {
//    case home
//    case cart
//    case productCard
//    case appDelegate
//}
//
//enum DestinationScreen {
//    case profile
//    case home
//    case checkout
//}

enum Router {
    case settings
    case help
    case setToken
    case distribute(apps: Apps?)
    case detailDistribute(apps: Apps?, appsRelease: AppsReleases?)
    
    private var storyboardName: String {
        switch self {
        case .settings: return "Settings"
        case .help: return "Help"
        case .setToken: return "SetToken"
        case .distribute: return "Distribute"
        case .detailDistribute: return "DetailDistribute" 
        }
    }
    
    private var viewController: UIViewController? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        switch self {
        default: return storyboard.instantiateInitialViewController()
        }
    }
}

extension Router {
    
    func push(from navigationController: UINavigationController?, animated: Bool = true) {
        switch self {
        case .settings:
            guard let vc = self.viewController as? SettingsTableViewController else { return }
            navigationController?.pushViewController(vc, animated: animated)
        case .help:
            guard let vc = self.viewController as? HelpVC else { return }
            navigationController?.pushViewController(vc, animated: animated)
        case .setToken:
            guard let vc = self.viewController as? SetTokenViewController else { return }
            navigationController?.pushViewController(vc, animated: animated)
        case .distribute(let apps):
            guard let vc = self.viewController as? DistributeViewController else { return }
            vc.apps = apps
            navigationController?.pushViewController(vc, animated: animated)
        case .detailDistribute(let apps, let appsRelease):
            guard let vc = self.viewController as? DetailDistributeViewController else { return }
            vc.apps = apps
            vc.appsRelease = appsRelease
            navigationController?.pushViewController(vc, animated: animated)
        }
    }
    
    func present(from viewController: UIViewController?, animated: Bool = true, modalTransitionStyle: UIModalTransitionStyle = .coverVertical, modalPresentationStyle: UIModalPresentationStyle = .fullScreen, completion: (() -> Void)? = nil) {
        switch self {
        case .settings, .help, .setToken:
            guard let vc = self.viewController else { return }
            vc.modalPresentationStyle = modalPresentationStyle
            vc.modalTransitionStyle = modalTransitionStyle
            viewController?.present(vc, animated: animated, completion: completion)
        case .distribute(let apps):
            guard let vc = self.viewController as? DistributeViewController else { return }
            vc.modalPresentationStyle = modalPresentationStyle
            vc.modalTransitionStyle = modalTransitionStyle
            vc.apps = apps
            viewController?.present(vc, animated: animated, completion: completion)
        case .detailDistribute(let apps, let appsRelease):
            guard let vc = self.viewController as? DetailDistributeViewController else { return }
            vc.modalPresentationStyle = modalPresentationStyle
            vc.modalTransitionStyle = modalTransitionStyle
            vc.apps = apps
            vc.appsRelease = appsRelease
            viewController?.present(vc, animated: animated, completion: completion)
        }
    }
    
}

