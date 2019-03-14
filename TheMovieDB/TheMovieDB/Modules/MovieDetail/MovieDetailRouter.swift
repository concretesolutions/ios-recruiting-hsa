import UIKit

class MovieDetailRouter: MovieDetailRouterProtocol {
    weak var viewController: UIViewController?

    func showErrorAlert(error _: Error, isSave: Bool) {
        let alertTitle = MovieDetailLocalizer.errorAlertTitle.localizedString
        let okButtonTitle = MovieDetailLocalizer.errorAlertOkButtonTitle.localizedString
        let alertMessage = isSave ? MovieDetailLocalizer.errorAlertSaveMovieMessage.localizedString : MovieDetailLocalizer.errorAlertUnsaveMovieMessage.localizedString

        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okButtonTitle, style: .default, handler: nil)
        alert.addAction(okAction)

        viewController?.present(alert, animated: true, completion: nil)
    }

    func dismiss() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
