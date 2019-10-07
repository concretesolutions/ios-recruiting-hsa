//
//  HomeViewController.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/2/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import UIKit

class HomeViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        let movieListModule = MovieListModule.init(rootNavigation: UINavigationController())
        let favoriteMoviesModule = FavoritesMoviesModule(navigation: UINavigationController())
        viewControllers = [movieListModule.router.navigation, favoriteMoviesModule.router.navigation]
    }

}
