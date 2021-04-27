import UIKit

class MainCoordinator: Coordinator {
    
    private let tabBarController: UITabBarController
    
    init(tabBarController: UITabBarController = UITabBarController()) {
        self.tabBarController = tabBarController
    }
    
    func start() {
        showFirstTabVC()
    }
}

extension MainCoordinator {
    func showFirstTabVC() {
        tabBarController.selectedIndex = 0
    }
    
    func showSecondTabVC() {
        tabBarController.selectedIndex = 1
    }
}
