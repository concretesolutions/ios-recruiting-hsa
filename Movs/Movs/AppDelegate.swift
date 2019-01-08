//
//  AppDelegate.swift
//  TMDB Reloaded
//
//  Created by Miguel Duran on 1/4/19.
//  Copyright © 2018 Miguel Duran. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var coordinator: MainFlowCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if let initialViewController = window?.rootViewController as? MainTabBarController {
            coordinator = MainFlowCoordinator(mainViewController: initialViewController)
            
            if Storage.fileExists(.movies, in: .documents) {
                let movies = Storage.retrieve(.movies, from: .documents, as: [Int:Movie].self)
                coordinator?.stateController.moviesDictionary = movies
            }
        }
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        guard let stateController = coordinator?.stateController else {
            return
        }
        Storage.store(stateController.moviesDictionary, to: Storage.Directory.documents, as: Storage.Files.movies)
    }
    
}

