//
//  AppDelegate.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/24/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    lazy var greetingsNavigationController: UINavigationController = {
        //let viewController = ViewControllerFactory.viewController(type: .greetings)
        let viewController = ViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.isNavigationBarHidden = true
        return navigationController
    }()
    
    func generateTabBarController()->UITabBarController{
        let tabBarController = UITabBarController()
        
        let favoritesVC = ViewController()
        favoritesVC.title = "Favorites"
        favoritesVC.view.backgroundColor = UIColor.orange
        let downloadsVC = ViewController()
        downloadsVC.title = "Downloads"
        downloadsVC.view.backgroundColor = UIColor.blue
        let historyVC = ViewController()
        historyVC.title = "History"
        historyVC.view.backgroundColor = UIColor.cyan
        
        
//        let button: UIButton = UIButton(frame: CGRect(x: view.bounds.width / 250, y: view.bounds.height / 2, width: 100, height: 50))
//        button.backgroundColor = UIColor.black
//        button.addTarget(self, action: #selector(pushToNextVC), for: .touchUpInside)
//        self.view.addSubview(button)
        
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        downloadsVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 1)
        historyVC.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 2)
        
        let controllers = [favoritesVC, downloadsVC, historyVC]
        tabBarController.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
        
        return tabBarController
    }

    func pushToNextVC() {
        let newVC = UIViewController()
        newVC.view.backgroundColor = UIColor.red
//        self.navigationController?.pushViewController(newVC, animated:
//            true)
    }

    func prepareWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        //window?.rootViewController = BackingViewController(rootViewController: greetingsNavigationController)
        window?.rootViewController = generateTabBarController()
        window?.makeKeyAndVisible()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        prepareWindow()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

