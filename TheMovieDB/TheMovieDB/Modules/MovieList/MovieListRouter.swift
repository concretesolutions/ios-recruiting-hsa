import UIKit

class MovieListRouter: MovieListRouterProtocol {

    var viewController: UIViewController?

    func showMovieDetail(movie: MovieModel, isIpad: Bool) {
        let movieDetailVC = MovieDetailWireframe.assemble(movie: movie, genres: [])

        if isIpad {
            let navController = UINavigationController(rootViewController: movieDetailVC)
            movieDetailVC.modalPresentationStyle = .formSheet
            viewController?.present(navController, animated: true, completion: nil)
        } else if let navController = self.viewController as? UINavigationController {
            navController.pushViewController(movieDetailVC, animated: true)
        }
    }

    func showErrorAlert(error: Error) {
        let alertTitle = "" //MovieDetailLocalizer.errorAlertTitle.localizedString
        let okButtonTitle = "" //MovieDetailLocalizer.errorAlertOkButtonTitle.localizedString
        let alertMessage = error.localizedDescription

        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okButtonTitle, style: .default, handler: nil)
        alert.addAction(okAction)

        viewController?.present(alert, animated: true, completion: nil)
    }
}
