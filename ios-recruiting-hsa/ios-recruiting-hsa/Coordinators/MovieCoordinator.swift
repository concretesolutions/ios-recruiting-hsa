//
//  MovieCoordinator.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/28/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation
import UIKit

class MovieCoordinator: Coordinator {

    var rootViewController: UIViewController!

    private let navigationController: UINavigationController
    private let modelManager: ModelManager

    init(navigationController: UINavigationController, modelManager: ModelManager) {
        self.navigationController = navigationController
        self.modelManager = modelManager
    }

    func start() {
        rootViewController = ListMovieWireframe.viewController(
            withDelegate: self,
            navigationBar: navigationController.navigationBar,
            modelManager: modelManager
        )
    }
}

extension MovieCoordinator: ListMovieViewDelegate {

    func listMovieView(_ viewController: ListMovieViewController, didSelect movie: PopularMovie) {
        let controller = DetailMovieWireframe.viewController(
            movie: movie,
            navigationBar: navigationController.navigationBar,
            modelManager: modelManager
        )
        navigationController.pushViewController(controller, animated: true)
        _ = controller.view
    }
}
