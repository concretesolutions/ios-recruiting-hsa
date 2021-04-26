import Foundation
import UIKit

class TabBarControllerMock: UITabBarController {
    var setViewController: [UIViewController]?
    var pushedViewController: (viewController: UIViewController, animated: Bool)?
    
    override func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
        setViewController = viewControllers
    }

}
