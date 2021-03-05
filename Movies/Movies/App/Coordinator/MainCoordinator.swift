//
//  MainCoordinator.swift
//  Movies
//
//  Created by Daniel Nunez on 03-03-21.
//

import UIKit

protocol MainCoordinatorProtocol: Coordinator {
    func showMainFlow()
}

class MainCoordinator: MainCoordinatorProtocol {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        navigationController.setNavigationBarHidden(true, animated: false)

        showMainFlow()
        fetchGenres()
    }

    func showMainFlow() {

        let tabCoordinator = TabCoordinator.init(navigationController)
        tabCoordinator.start()
        childCoordinators.append(tabCoordinator)
    }

    func fetchGenres() {

        let service = GenreServices()
        let cache = CacheManager()
        service.fetchGenres({ response in

            guard let temp = response else { return }
            cache.saveGenre(items: temp)

        }, errorCompletion: {})


    }


}
