//
//  MainTabBarController.swift
//  MoviesApp
//
//  Created by Hector Morales on 2/27/21.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTabBar()
    }

    private func setupUI() {
        UITabBar.appearance().barTintColor = UIColor.darkGray
        UITabBar.appearance().tintColor = .systemYellow
        UITabBar.appearance().unselectedItemTintColor = .white
    }

    fileprivate func setupTabBar(){
        let vc = MovieListVC()
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.isHidden = true
        nav.navigationBar.barTintColor = .white
        vc.tabBarItem = UITabBarItem(title: Localizables.moviesTitle, image: #imageLiteral(resourceName: "list_icon"), selectedImage: #imageLiteral(resourceName: "list_icon"))
        let vc2 = FavoritesListVC()
        vc2.tabBarItem = UITabBarItem(title: Localizables.favoritesTitle, image: #imageLiteral(resourceName: "favorite_empty_icon") , selectedImage: #imageLiteral(resourceName: "favorite_empty_icon"))
        let controllers = [vc,vc2]
        self.viewControllers = controllers
    }

}
