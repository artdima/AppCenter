//
//  Router.swift
//  AppCenter
//
//  Created by Medyannik Dmitri on 25.01.2020.
//  Copyright © 2020 Medyannik Dima. All rights reserved.
//

import UIKit

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
            guard let vc = self.viewController as? DistributeViewController, let apps = apps else { return }
            vc.viewModel = DistributeViewModel(apps: apps)
            navigationController?.pushViewController(vc, animated: animated)
        case .detailDistribute(let apps, let appsRelease):
            guard let vc = self.viewController as? DetailDistributeViewController, let apps = apps, let appsRelease = appsRelease else { return }
            vc.viewModel = DetailDistributeViewModel(apps: apps, appsRelease: appsRelease)
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
            guard let vc = self.viewController as? DistributeViewController, let apps = apps else { return }
            vc.modalPresentationStyle = modalPresentationStyle
            vc.modalTransitionStyle = modalTransitionStyle
            vc.viewModel = DistributeViewModel(apps: apps)
            viewController?.present(vc, animated: animated, completion: completion)
        case .detailDistribute(let apps, let appsRelease):
            guard let vc = self.viewController as? DetailDistributeViewController, let apps = apps, let appsRelease = appsRelease else { return }
            vc.modalPresentationStyle = modalPresentationStyle
            vc.modalTransitionStyle = modalTransitionStyle
            vc.viewModel = DetailDistributeViewModel(apps: apps, appsRelease: appsRelease)
            viewController?.present(vc, animated: animated, completion: completion)
        }
    }
    
}

