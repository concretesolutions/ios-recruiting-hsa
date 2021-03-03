//
//  MovieCoordinator.swift
//  Movies
//
//  Created by Daniel Nunez on 03-03-21.
//

import UIKit

class MovieCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let moviewVC = MovieListController()
        moviewVC.coordinator = self
        navigationController.pushViewController(moviewVC, animated: false)
    }


}
