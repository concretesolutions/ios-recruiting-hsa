//
//  Coordinator.swift
//  Movies
//
//  Created by Daniel Nunez on 03-03-21.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
