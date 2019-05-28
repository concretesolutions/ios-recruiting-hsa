//
//  AppDelegate.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/27/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: Coordinator?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let navigationAppearance = UINavigationBar.appearance()
        navigationAppearance.isTranslucent = false
        navigationAppearance.barTintColor = .app

        let window = UIWindow()
        self.window = window
        self.coordinator = MainCoordinator(window: window)
        coordinator?.start()
        return true
    }

}
