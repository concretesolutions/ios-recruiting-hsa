//
//  AppDelegate.swift
//  Movs
//
//  Created by Jose Antonio Aravena on 9/3/19.
//  Copyright © 2019 Jose Antonio Aravena. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.5))
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        
        let moviesViewController =  MoviesViewController()
        moviesViewController.tabBarItem =  UITabBarItem(title: "movies" , image: UIImage(named: "list"), tag: 0)
        
        let favoritesViewController = FavoritesTableViewController()
        favoritesViewController.tabBarItem = UITabBarItem(title: "favorites" , image: UIImage(named: "fav"), tag: 1)

        
        
        let viewControllerListB = [ moviesViewController, favoritesViewController ]
        
        
        
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = viewControllerListB.map { UINavigationController(rootViewController: $0) }
        
        
        tabBarController.tabBar.tintColor = .negro
        //tabBarController.tabBar.unselectedItemTintColor = .cafe
        
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.barTintColor = .amarillo
        self.window?.rootViewController = MoviesNavigationViewController(rootViewController:tabBarController)
        
        
        
        self.window?.makeKeyAndVisible()
        return true
    }

}

