//
//  MainCoordinator.swift
//  Movies
//
//  Created by Pedro on 25-07-24.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    let moviesCoordinator: MoviesCoordinator
    let favoritesCoordinator: FavoritesCoordinator

    init(navigationController: UINavigationController,
         moviesCoordinator: MoviesCoordinator,
         favoritesCoordinator: FavoritesCoordinator) {
        self.navigationController = navigationController
        self.moviesCoordinator = moviesCoordinator
        self.favoritesCoordinator = favoritesCoordinator
    }

    func start() {
        moviesCoordinator.start()
        favoritesCoordinator.start()

        let tabsController = UITabBarController()
        tabsController.viewControllers = [
            moviesCoordinator.navigationController,
            favoritesCoordinator.navigationController
        ]

        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(tabsController, animated: false)
    }
}
