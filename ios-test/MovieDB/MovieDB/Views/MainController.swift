//
//  MainController.swift
//  MovieDB
//
//  Created by Eddwin Paz on 9/6/19.
//  Copyright © 2019 acme dot inc. All rights reserved.
//

import UIKit

class MainController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [
            self.createNavControllerWithTitle(controller: MoviesController(), title: "Movies", imageName: "list_icon"),
            self.createNavControllerWithTitle(controller: FavoritesController(), title: "Favorites", imageName: "favorite_empty_icon"),
        ]
    }
}
