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
        let listNavigator = UINavigationController()
        let listController = ListMovieViewController(navigationBar: listNavigator.navigationBar)
        listNavigator.setViewControllers([listController], animated: false)

        let favoriteNavigator = UINavigationController()
        let favoriteController = FavoriteMoviesViewController(
            navigationBar: favoriteNavigator.navigationBar
        )
        favoriteNavigator.setViewControllers([favoriteController], animated: false)
        let navigation = [listNavigator, favoriteNavigator]
        tabbarController.setViewControllers(navigation, animated: false)
        window.rootViewController = tabbarController
        window.makeKeyAndVisible()
    }
}
