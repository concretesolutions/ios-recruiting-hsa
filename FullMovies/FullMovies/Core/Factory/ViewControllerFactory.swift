import UIKit

class ViewControllerFactory {
    
    class func popularMoviesVC() -> UIViewController {
        let serviceLocator = PopularMoviesServiceLocator()
        let viewDataSource = PopularMoviesDataSource()
        let viewDelegate = PopularMoviesDelegate()
        let presenter = PopularMoviesPresenter(
            usecase: serviceLocator.getPopularMoviesUseCase,
            moviesModelMapper: serviceLocator.moviesModelMapper
        )
        
        return PopularMoviesVC(
            presenter: presenter,
            dataSource: viewDataSource,
            delegate : viewDelegate)
    }
    
    class func favoritesMoviesVC() -> UIViewController {
        return FavoritesVC()
    }
    
    
    class func tabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        let pupularMoviesVC = popularMoviesVC()
        let favsVC = favoritesMoviesVC() // TO DO: change this
        
        tabBarController.viewControllers = [
            tabBar(childController: pupularMoviesVC, title: Constants.TabBar.movies),
            tabBar(childController: favsVC, title: Constants.TabBar.favs)
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
        case is FavoritesVC:
            return Image.Icon.favs
        default:
            return Image.Icon.favs
        }
    }
}
