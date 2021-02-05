//
//  AppDelegate.swift
//  concreteIOSRecruitChallenge
//
//  Created by Kristian Sthefan Cortes Prieto on 04-02-21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let initialViewController = UINavigationController(rootViewController: HomeViewController())
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.barTintColor =  UIColor(named: "main_color")
        navigationBarAppearace.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

