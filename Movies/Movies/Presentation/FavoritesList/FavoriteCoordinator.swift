//
//  FavoriteCoordinator.swift
//  Movies
//
//  Created by Daniel Nunez on 03-03-21.
//

import UIKit

class FavoriteCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let favoriteScene = MoviesFactory.makeFavoriteScene()
        navigationController.pushViewController(favoriteScene, animated: true)
    }


}
