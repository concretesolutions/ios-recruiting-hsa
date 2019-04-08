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
    
    var moviesViewController : MoviesViewController!
    var favoritesViewController : FavoritesMovieViewController!
    let searchController = UISearchController(searchResultsController: nil)


    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = #colorLiteral(red: 0.01874381118, green: 0.2028939426, blue: 0.3979796767, alpha: 1)
        UITabBar.appearance().tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        createMoviesViewController()
        createFavoritesViewController()
        addViewsControllers()
        addSearchViewController()
    }
    
    func addSearchViewController(){
        searchController.searchResultsUpdater = moviesViewController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        self.navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
}

extension HomeViewController : HomeViewProtocol{
    
    func createMoviesViewController(){
        moviesViewController = MoviesViewController(nibName: "MoviesViewController", bundle: nil)
        moviesViewController.searchBarHome = searchController
        moviesViewController.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(named: "list_icon"), tag: 0)
    }
    
    func createFavoritesViewController(){
        favoritesViewController = FavoritesMovieViewController(nibName: "FavoritesMovieViewController", bundle: nil)
        favoritesViewController.tabBarItem = UITabBarItem(title: "Favorities", image: UIImage(named: "favorite_empty_icon"), tag: 0)
    }
    
    func addViewsControllers() {
        viewControllers = [moviesViewController,favoritesViewController]
    }
}




