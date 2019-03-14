import UIKit

class SavedMoviesRouter: SavedMoviesRouterProtocol {
    var viewController: UIViewController?
    weak var navigationController: UINavigationController?

    func showFilterView() {}

    func showErrorAlert(error _: Error) {}

    func showMovieDetail(movie _: MovieModel, genres _: [String], isIpad _: Bool) {}
}
