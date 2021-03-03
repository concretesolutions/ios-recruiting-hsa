//
//  MainTabBarController.swift
//  Movies
//
//  Created by Daniel Nunez on 03-03-21.
//

import UIKit

class MainTabBarController: UITabBarController {

    let main = MainCoordinator(navigationController:
        UINavigationController())

    override func viewDidLoad() {
        super.viewDidLoad()

        main.start()
        viewControllers = [main.navigationController]

    }


}
