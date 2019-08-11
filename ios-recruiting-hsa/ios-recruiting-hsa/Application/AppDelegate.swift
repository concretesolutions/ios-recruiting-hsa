//
//  AppDelegate.swift
//  ios-recruiting-hsa
//
//  Created on 07-08-19.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        navigationBarAppearance()
        let viewController = ViewFactory.viewController(viewType: .tab)
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.isNavigationBarHidden = true
        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
        
        return true
    }
    
    func navigationBarAppearance(){
        UINavigationBar.appearance().barTintColor = Constants.Colors.brand
        UINavigationBar.appearance().tintColor = Constants.Colors.dark
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
}

