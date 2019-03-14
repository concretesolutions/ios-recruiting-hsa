import UIKit

class MainViewController: UITabBarController {
    convenience init(viewControllers: [UIViewController]) {
        self.init()
        self.viewControllers = viewControllers
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
