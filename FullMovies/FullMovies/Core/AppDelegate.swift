import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private var appCoordinator: AppCoordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupAppearance()
        appCoordinator = AppCoordinator(tabBarController: ViewControllerFactory.tabBarController())
        appCoordinator.start()
        return true
    }
    
    private func setupAppearance() {
        let navigation = UINavigationBar.appearance()
        navigation.barTintColor = .yellow
        navigation.tintColor = .black

        navigation.isTranslucent = false
        navigation.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navigation.shadowImage = UIImage()

        let tabBar = UITabBar.appearance(whenContainedInInstancesOf: [UITabBarController.self])
        tabBar.unselectedItemTintColor = .darkGray
        tabBar.tintColor = .black
        tabBar.barTintColor = .yellow
        tabBar.isTranslucent = false
    }
}

