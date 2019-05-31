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

    private let navigationController: UINavigationController
    private let modelManager: ModelManager

    init(navigationController: UINavigationController, modelManager: ModelManager) {
        self.navigationController = navigationController
        self.modelManager = modelManager
    }

    func start() {
        let controller = ListMovieWireframe.viewController(
            navigationBar: navigationController.navigationBar,
            modelManager: modelManager
        )
        navigationController.viewControllers = [controller]
    }
}
