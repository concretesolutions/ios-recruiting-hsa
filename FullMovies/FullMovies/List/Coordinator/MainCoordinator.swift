import UIKit

class MainCoordinator: Coordinator {

    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() {
        showFirstScene()
    }
}

extension MainCoordinator {
    func showFirstScene() {
        //TO DO: call tabBarController
    }
}
