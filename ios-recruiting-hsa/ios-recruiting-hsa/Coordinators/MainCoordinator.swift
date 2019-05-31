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
    private var movieCoordinator: MovieCoordinator!

    private lazy var modelManager: ModelManager = modelManagerDefault()
    private var tabbarController: UITabBarController!

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        self.tabbarController = UITabBarController()

        let controllers = [UINavigationController(), UINavigationController()]
        movieCoordinator = MovieCoordinator(
            navigationController: controllers[0],
            modelManager: modelManager
        )
        movieCoordinator.start()

        let favoriteController = FavoriteMoviesViewController(
            navigationBar: controllers[1].navigationBar
        )
        controllers[1].setViewControllers([favoriteController], animated: false)
        tabbarController.setViewControllers(controllers, animated: false)
        window.rootViewController = tabbarController
        window.makeKeyAndVisible()
    }
}
