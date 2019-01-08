//
//  MainFlowCoordinator.swift
//  TMDB Reloaded
//
//  Created by Miguel Duran on 1/5/19.
//  Copyright © 2019 Miguel Duran. All rights reserved.
//

import UIKit

// MARK: Protocols
protocol Coordinator: AnyObject {
    func configure(viewController: UIViewController)
}

protocol MovieDetailsCoordinated: AnyObject {
    var movieDetailsCoordinator: MovieDetailsFlowCoordinator? { get set }
}

protocol Networked: AnyObject {
    var networkController: NetworkController? { get set }
}

protocol Stateful: AnyObject {
    var stateController: StateController? { get set }
}

// MARK: - MainFlowCoordinator
class MainFlowCoordinator: NSObject {
    let mainTabBarController: MainTabBarController
    let stateController = StateController()
    let movieDetailsFlowCoordinator = MovieDetailsFlowCoordinator()
    
    init(mainViewController: MainTabBarController) {
        self.mainTabBarController = mainViewController
        super.init()
        movieDetailsFlowCoordinator.parent = self
        configure(viewController: mainViewController)
    }
}

// MARK: Coordinator
extension MainFlowCoordinator: Coordinator {
    func configure(viewController: UIViewController) {
        (viewController as? Networked)?.networkController = NetworkController()
        (viewController as? MovieDetailsCoordinated)?.movieDetailsCoordinator = movieDetailsFlowCoordinator
        (viewController as? Stateful)?.stateController = stateController

        if let tabBarController = viewController as? UITabBarController {
            tabBarController.viewControllers?.forEach(configure(viewController:))
        }
        if let navigationController = viewController as? UINavigationController, let rootViewController = navigationController.viewControllers.first {
            configure(viewController: rootViewController)
        }
    }
}
