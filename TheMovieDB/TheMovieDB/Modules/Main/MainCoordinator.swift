import Foundation
import UIKit

class MainCoordinator {
    static func assemble() -> UIViewController {
        let listViewNavController = MovieListWireframe.assemble()
        let savedMoviesNavController = SavedMoviesWireframe.assemble()
        let mainViewController = MainViewController(viewControllers: [listViewNavController, savedMoviesNavController])

        if let listViewController = listViewNavController.viewControllers.first as? MovieListViewController,
            let savedMoviesViewController = savedMoviesNavController.viewControllers.first as? SavedMoviesViewController {
            savedMoviesViewController.savedAdsDelegate = listViewController
            savedMoviesViewController.setupTabBarItem()
        }

        return mainViewController
    }
}
