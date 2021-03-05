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
    }

    func showMainFlow() {

        let tabCoordinator = TabCoordinator.init(navigationController)
        tabCoordinator.start()
        childCoordinators.append(tabCoordinator)
    }


}
