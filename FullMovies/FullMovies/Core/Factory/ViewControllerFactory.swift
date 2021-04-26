import UIKit

class ViewControllerFactory {
    
    class func popularMoviesVC() -> UIViewController {
        return PopularMoviesVC()
    }
    
    class func tabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        let pupularMoviesVC = popularMoviesVC()
        let favsVC = popularMoviesVC()
        
        tabBarController.viewControllers = [
            tabBar(childController: pupularMoviesVC, title: "Movies"),
            tabBar(childController: favsVC, title: "Favs")
        ]        
        return tabBarController
    }
    
    private class func tabBar(childController: UIViewController, title: String) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: childController)
        navigationController.tabBarItem.image = tabBarIcon(viewController: childController)
        navigationController.tabBarItem.title = title
        navigationController.navigationBar.shadowImage = UIImage()
        return navigationController
    }
    
    private class func tabBarIcon(viewController: UIViewController) -> UIImage? {
        switch viewController {
        case is PopularMoviesVC:
            return Image.Icon.list
        default:
            return Image.Icon.favs
        }
    }
}
