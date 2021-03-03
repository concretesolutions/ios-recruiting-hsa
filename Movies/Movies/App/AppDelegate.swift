//
//  AppDelegate.swift
//  Movies
//
//  Created by Daniel Nunez on 03-03-21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    var moviesVC : UINavigationController!
    var favoritesVC : UINavigationController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.black

        let tabBarController = UITabBarController()

        moviesVC = UINavigationController.init(rootViewController: ViewController())
        favoritesVC = UINavigationController.init(rootViewController: ViewController())

        tabBarController.viewControllers = [moviesVC, favoritesVC]


        moviesVC.title = "Peliculas"
        favoritesVC.title = "Favoritos"
        let item1 = UITabBarItem(title: "Peliculas", image: #imageLiteral(resourceName: "list_icon"), tag: 0)
        let item2 = UITabBarItem(title: "Favoritos", image: #imageLiteral(resourceName: "favorite_empty_icon"), tag: 1)

        moviesVC.tabBarItem = item1
        favoritesVC.tabBarItem = item2

        UITabBar.appearance().barTintColor = UIColor.darkGray
        UITabBar.appearance().tintColor = .systemYellow
        UITabBar.appearance().unselectedItemTintColor = .white

        self.window?.rootViewController = tabBarController

        window?.makeKeyAndVisible()

        return true
    }


}

