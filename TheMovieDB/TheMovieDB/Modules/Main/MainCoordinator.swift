import Foundation
import UIKit

class MainCoordinator {
    static func assemble() -> UIViewController {
        let listViewNavController = MovieListWireframe.assemble()
        let mainViewController = MainViewController(viewControllers: [listViewNavController])
        return mainViewController
    }
}
