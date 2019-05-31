//
//  FavoriteCoordinator.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/31/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation
import UIKit

class FavoriteCoordinator: Coordinator {

    var rootViewController: UIViewController!

    private let navigationController: UINavigationController
    private let appDependencies: AppDependencies

    init(navigationController: UINavigationController, appDependencies: AppDependencies) {
        self.navigationController = navigationController
        self.appDependencies = appDependencies
    }

    func start() {
        rootViewController = FavoriteMoviesWireframe.viewController(
            withDelegate: self,
            appDependencies: appDependencies
        )
    }
}

extension FavoriteCoordinator: FavoriteMoviesViewDelegate {

    func favoriteMovieView(
        _ viewController: FavoriteMoviesViewController,
        didSelect movie: PopularMovie
    ) {
        let controller = DetailMovieWireframe.viewController(
            movie: movie,
            appDependencies: appDependencies
        )
        navigationController.pushViewController(controller, animated: true)
    }
}
