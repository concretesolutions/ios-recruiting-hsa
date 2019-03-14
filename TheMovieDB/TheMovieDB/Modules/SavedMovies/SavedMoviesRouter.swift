import UIKit

class SavedMoviesRouter: SavedMoviesRouterProtocol {
    weak var viewController: UIViewController?
    weak var navigationController: UINavigationController?

    func showFilterView() {}

    func showMovieDetail(movie: MovieModel, genres: [String], isIpad: Bool, savedAdsDelegate: MovieListSavedAdsUpdate?) {
        let movieDetailVC = MovieDetailWireframe.assemble(movie: movie, genres: genres, savedAdsDelegate: savedAdsDelegate)

        if isIpad {
            let navController = UINavigationController(rootViewController: movieDetailVC)
            movieDetailVC.modalPresentationStyle = .formSheet
            viewController?.present(navController, animated: true, completion: nil)
        } else {
            movieDetailVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(movieDetailVC, animated: true)
        }
    }

    func showErrorAlert(error: Error) {
        let alertTitle = MovieListLocalizer.errorAlertTitle.localizedString
        let okButtonTitle = MovieListLocalizer.errorAlertOkButton.localizedString
        let alertMessage = error.localizedDescription

        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okButtonTitle, style: .default, handler: nil)
        alert.addAction(okAction)

        viewController?.present(alert, animated: true, completion: nil)
    }
}
