import UIKit

protocol SavedMoviesWireframeProtocol: class {
    static func assemble() -> UINavigationController
}

protocol SavedMoviesViewProtocol: class {
    var presenter: SavedMoviesPresenterProtocol? { get set }

    func showLoading()
    func hideLoading()
    func setMovies(_ movies: [MovieModel])
    func showMessage(_ message: String)
}

protocol SavedMoviesInteractorProtocol: class {
    var delegate: SavedMoviesInteractorDelegate? { get set }

    func fetchSavedMovies()
    func unsaveMovie(movieId: Int32)
}

protocol SavedMoviesInteractorDelegate: class {
    func fetchSavedMoviesSuccess(savedMovies: [MovieModel])
    func fetchSavedMoviesFail(error: Error)

    func unsaveMovieSuccess()
    func unsaveMovieFail(error: Error)
}

protocol SavedMoviesPresenterProtocol: class {
    var view: SavedMoviesViewProtocol? { get set }
    var interactor: SavedMoviesInteractorProtocol? { get set }
    var router: SavedMoviesRouterProtocol? { get set }

    func viewDidLoad()
    func willDeleteMovie(movieId: Int32)
    func filterButtonTapped()
    func didTapInMovieCell(movie: MovieModel, genres: [String], isIpad: Bool, savedAdsDelegate: MovieListSavedAdsUpdate?)
}

protocol SavedMoviesRouterProtocol: class {
    var viewController: UIViewController? { get set }

    func showFilterView()
    func showErrorAlert(error: Error)
    func showMovieDetail(movie: MovieModel, genres: [String], isIpad: Bool, savedAdsDelegate: MovieListSavedAdsUpdate?)
}
