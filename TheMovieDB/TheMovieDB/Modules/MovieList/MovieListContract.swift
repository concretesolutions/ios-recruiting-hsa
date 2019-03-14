import UIKit

protocol MovieListWireframeProtocol: class {
    static func assemble() -> UINavigationController
}

protocol MovieListViewProtocol: class {
    var presenter: MovieListPresenterProtocol? { get set }

    func setMovies(movies: [MovieModel], append: Bool)
    func setSavedMoviesIds(ids: [Int32], append: Bool)
    func setGenres(genres: [GenreModel])

    func showLoading()
    func hideLoading()
}

protocol MovieListInteractorProtocol: class {
    var delegate: MovieListInteractorDelegate? { get set }

    func fetchMovies(page: Int, append: Bool)
    func fetchGenres()
    func fetchSavedMoviesIds(append: Bool)
}

protocol MovieListInteractorDelegate: class {
    func fetchMoviesSuccess(movies: [MovieModel], append: Bool)
    func fetchMoviesFail(error: Error)

    func fetchGenresSuccess(genres: [GenreModel])
    func fetchGenresFail(error: Error)

    func fetchSavedMoviesIdsSuccess(ids: [Int32], append: Bool)
    func fetchSavedMoviesIdsFail(error: Error)
}

protocol MovieListPresenterProtocol: class {
    var view: MovieListViewProtocol? { get set }
    var interactor: MovieListInteractorProtocol? { get set }
    var router: MovieListRouterProtocol? { get set }

    func viewDidLoad()
    func willLoadMovies(page: Int, append: Bool)
    func willLoadGenres()
    func didTapInMovieCell(movie: MovieModel, genres: [String], isIpad: Bool, savedAdsDelegate: MovieListSavedAdsUpdate?)
}

protocol MovieListRouterProtocol: class {
    var viewController: UIViewController? { get set }

    func showMovieDetail(movie: MovieModel, genres: [String], isIpad: Bool, savedAdsDelegate: MovieListSavedAdsUpdate?)
    func showErrorAlert(error: Error)
}

protocol MovieListSavedAdsUpdate: class {
    func didUpdateSavedMovieState(movieId: Int32?, saved: Bool)
}
