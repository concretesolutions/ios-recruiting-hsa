//
//  AppDelegate.swift
//  Movies
//
//  Created by Daniel Nunez on 03-03-21.
//

import IQKeyboardManagerSwift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var coordinator: MainCoordinator?
    var window: UIWindow?

    func application(_: UIApplication,
                     didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        IQKeyboardManager.shared.enable = true

        let navigationController: UINavigationController = .init()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        coordinator = MainCoordinator(navigationController: navigationController)
        coordinator?.start()

        return true
    }
}
