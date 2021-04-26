import UIKit

class ViewControllerFactory {
    
    class func popularMoviesVC() -> UIViewController {
        let popularVC =  PopularMoviesVC()
        let serviceLocator = PopularMoviesServiceLocator()
        let presenter = PopularMoviesPresenter(view: popularVC, usecase: serviceLocator.getPopularMoviesUseCase)
        popularVC.presenter = presenter
        return popularVC
    }
    
    class func tabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        let pupularMoviesVC = popularMoviesVC()
        let favsVC = popularMoviesVC() // TO DO: change this
        
        tabBarController.viewControllers = [
            tabBar(childController: pupularMoviesVC, title: "Movies"),
            tabBar(childController: favsVC, title: "Favs")
        ]//TO DO: change "movies" to localizable file
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
