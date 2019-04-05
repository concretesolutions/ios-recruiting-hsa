//
//  ViewController.swift
//  MovieApp
//
//  Created by Sebastian Diaz on 4/3/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import UIKit

protocol HomeViewProtocol {
    func createMoviesViewController()
    func createFavoritesViewController()
    func addViewsControllers()
}



class HomeViewController: UITabBarController {
    
    var moviesViewController : UIViewController!
    var favoritesViewController : UIViewController!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        createMoviesViewController()
        createFavoritesViewController()
        addViewsControllers()
    }
    
}

extension HomeViewController : HomeViewProtocol{
    
    func createMoviesViewController(){
        moviesViewController = MoviesViewController(nibName: "MoviesViewController", bundle: nil)
        moviesViewController.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "list_icon"), tag: 0)
    }
    
    func createFavoritesViewController(){
        favoritesViewController = UIViewController()
        favoritesViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
    }
    
    func addViewsControllers() {
        viewControllers = [moviesViewController,favoritesViewController]
    }
}


