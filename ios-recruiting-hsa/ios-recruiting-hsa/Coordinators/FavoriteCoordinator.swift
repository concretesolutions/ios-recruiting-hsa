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

    let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let controller = FavoriteMoviesWireframe.viewController()
        navigationController.viewControllers = [controller]

        _ = controller.view
    }
}
