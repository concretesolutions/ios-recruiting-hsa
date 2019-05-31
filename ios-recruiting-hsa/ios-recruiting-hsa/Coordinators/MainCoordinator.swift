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
    private var favoriteCoordinator: FavoriteCoordinator!

    private lazy var modelManager: ModelManager = modelManagerDefault()

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let navigation = UINavigationController()
        movieCoordinator = MovieCoordinator(
            navigationController: navigation,
            modelManager: modelManager
        )
        movieCoordinator.start()

        favoriteCoordinator = FavoriteCoordinator(navigationController: navigation)
        favoriteCoordinator.start()

        let controllers: [UIViewController] = [
            movieCoordinator.rootViewController,
            favoriteCoordinator.rootViewController,
        ]
        controllers.forEach { _ = $0.view }
        let tabbarController = UITabBarController()
        tabbarController.setViewControllers(controllers, animated: false)
        navigation.viewControllers = [tabbarController]
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
}
