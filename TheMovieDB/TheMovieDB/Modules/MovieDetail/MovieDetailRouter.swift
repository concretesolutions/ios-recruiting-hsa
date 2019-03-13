import UIKit

class MovieDetailRouter: MovieDetailRouterProtocol {

    weak var viewController: UIViewController?

    func showErrorAlert(error: Error) {}
    func dismiss() {}
}
