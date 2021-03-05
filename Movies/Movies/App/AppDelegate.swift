//
//  AppDelegate.swift
//  Movies
//
//  Created by Daniel Nunez on 03-03-21.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var coordinator: MainCoordinator?
    var window: UIWindow?

    func application(_ application: UIApplication,
         didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow.init(frame: UIScreen.main.bounds)
        IQKeyboardManager.shared.enable = true

        let navigationController: UINavigationController = .init()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        coordinator = MainCoordinator.init(navigationController: navigationController)
        coordinator?.start()

        return true
    }


}

