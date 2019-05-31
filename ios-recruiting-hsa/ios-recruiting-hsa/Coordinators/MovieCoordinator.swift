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
    private let appDependencies: AppDependencies

    init(navigationController: UINavigationController, appDependencies: AppDependencies) {
        self.navigationController = navigationController
        self.appDependencies = appDependencies
    }

    func start() {
        rootViewController = ListMovieWireframe.viewController(
            withDelegate: self,
            navigationBar: navigationController.navigationBar,
            appDependencies: appDependencies
        )
    }
}

extension MovieCoordinator: ListMovieViewDelegate {

    func listMovieView(_ viewController: ListMovieViewController, didSelect movie: PopularMovie) {
        let controller = DetailMovieWireframe.viewController(
            movie: movie,
            appDependencies: appDependencies
        )
        navigationController.pushViewController(controller, animated: true)
        _ = controller.view
    }
}
