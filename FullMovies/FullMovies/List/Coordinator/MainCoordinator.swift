import UIKit

class MainCoordinator: Coordinator {
    
    private let tabBarController: UITabBarController
    
    init(tabBarController: UITabBarController = UITabBarController()) {
        self.tabBarController = tabBarController
    }
    
    func start() {
        showFirstVC()
    }
}

extension MainCoordinator {
    func showFirstVC() {
        tabBarController.selectedIndex = 0
    }
}
