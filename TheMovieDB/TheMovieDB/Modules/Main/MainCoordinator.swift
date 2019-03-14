import Foundation
import UIKit

class MainCoordinator {
    static func assemble() -> UIViewController {
        let listViewNavController = MovieListWireframe.assemble()
        let savedMoviesNavController = SavedMoviesWireframe.assemble()
        let mainViewController = MainViewController(viewControllers: [listViewNavController, savedMoviesNavController])
        return mainViewController
    }
}
