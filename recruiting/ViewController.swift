//
//  ViewController.swift
//  recruiting
//
//  Created by Diego Vargas on 4/20/19.
//  Copyright © 2019 concrete. All rights reserved.
//

import UIKit

class ViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let popularView = GenericSceneBuilder.build(fileName: "views3")
        
        let icon1 = UITabBarItem(title: "Peliculas", image: UIImage(named: "list_icon"), selectedImage: UIImage(named: "list_icon"))
        popularView.tabBarItem = icon1
        let favoritesView = FavoritesTableViewController()
        let icon2 = UITabBarItem(title: "Favoritos", image: UIImage(named: "favorite_empty_icon"), selectedImage: UIImage(named: "favorite_empty_icon"))
        favoritesView.tabBarItem = icon2
        
        let controllers = [popularView, favoritesView]
        self.viewControllers = controllers
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true;
    }
}

