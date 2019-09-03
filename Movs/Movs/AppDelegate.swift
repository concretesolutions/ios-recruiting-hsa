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
        //self.window?.rootViewController = UIViewController.init()
        self.window?.rootViewController = FavoritesTableViewController.init()
        
        //let moviewNavigationViewController = MoviesNavigationViewController(rootViewController: MoviesNavigationViewController.init())
        //self.window?.rootViewController = moviewNavigationViewController
        
        self.window?.makeKeyAndVisible()
        return true
    }

}

