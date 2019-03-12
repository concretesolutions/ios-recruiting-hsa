import UIKit

class MovieDetailRouter: MovieDetailRouterProtocol {

    var viewController: UIViewController?

    func showErrorAlert(error: Error) {}
    func dismiss() {}
}
