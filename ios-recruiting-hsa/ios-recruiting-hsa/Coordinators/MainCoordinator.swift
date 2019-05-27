//
//  MainCoordinator.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/27/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {

    private let window: UIWindow
    private let tabbarController: UITabBarController

    init(window: UIWindow) {
        self.window = window
        self.tabbarController = UITabBarController()
    }

    func start() {
        let navigation = [UINavigationController(), UINavigationController()]

        tabbarController.setViewControllers(navigation, animated: false)
        window.rootViewController = tabbarController
        window.makeKeyAndVisible()
    }
}
