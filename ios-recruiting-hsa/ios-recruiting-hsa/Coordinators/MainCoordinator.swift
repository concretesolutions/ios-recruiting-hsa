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

    private lazy var appDependecies = buildDependencies()
    private lazy var modelManager: ModelManager = modelManagerDefault()

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let navigation = UINavigationController()
        movieCoordinator = MovieCoordinator(
            navigationController: navigation,
            appDependencies: appDependecies
        )
        movieCoordinator.start()

        favoriteCoordinator = FavoriteCoordinator(
            navigationController: navigation,
            appDependencies: appDependecies
        )
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

private  extension MainCoordinator {

    func buildDependencies() -> AppDependencies {
        let dependencies = AppDependencies(
            favoritesManager: favoritesManagerDefault(),
            modelManager: modelManagerDefault()
        )
        return dependencies
    }
}
