import UIKit
import Foundation

class AppCoordinator: Coordinator {
    
    private let window: UIWindow
    private let tabBarController: UITabBarController
    var starterCoordinator: Coordinator?
    
    init(window: UIWindow = UIWindow(),
         tabBarController: UITabBarController = UITabBarController()) {
        self.window = window
        self.tabBarController = tabBarController
        setupWindow()
        setupStarterCoordinator()
    }
    
    func setupWindow() {
        self.window.rootViewController = tabBarController
        self.window.makeKeyAndVisible()
    }
    
    func setupStarterCoordinator() {
        starterCoordinator = MainCoordinator(tabBarController: tabBarController)
    }
    
    func start() {
        starterCoordinator?.start()
    }
}
