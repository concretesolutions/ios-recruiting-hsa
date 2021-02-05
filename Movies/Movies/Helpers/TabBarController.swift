//
//  TabBarController.swift
//  Movies
//
//  Created by Mavericks's iOS Dev on 29-07-20.
//  Copyright © 2020 Alfredo Luco. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewControllers = [MoviesRouter.createModule()]
        // Do any additional setup after loading the view.
    }

}
