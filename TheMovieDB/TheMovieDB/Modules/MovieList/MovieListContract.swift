import UIKit

protocol MovieListWireframeProtocol: class {
    static func assemble(savedMoviesRepository: SavedMoviesRepositoryProtocol, movieDBRepository: MovieDBRepositoryProtocol, configurations: ConfigurationsProtocol) -> UIViewController
}

protocol MovieListViewProtocol: class {
    var presenter: MovieListPresenterProtocol? { get set }

    func setMovies(movies: [MovieModel], append: Bool)
    func setSavedMoviesIds(ids: [Int], append: Bool)

    func showLoading()
    func hideLoading()
}

protocol MovieListInteractorProtocol: class {
    var delegate: MovieListInteractorDelegate? { get set }

    func fetchMovies(page: Int, append: Bool)
    func getGenres()
    func fetchSavedMoviesIds(append: Bool)
}

protocol MovieListInteractorDelegate: class {
    func fetchMoviesSuccess(movies: [MovieModel], append: Bool)
    func fetchMoviesFail(error: Error)

    func fetchGenresSuccess(genres: [GenreModel])
    func fetchGenresFail(error: Error)

    func fetchSavedMoviesIdsSuccess(ids: [Int], append: Bool)
    func fetchSavedMoviesIdsFail(error: Error)
}

protocol MovieListPresenterProtocol: class {
    var view: MovieListViewProtocol? { get set }
    var interactor: MovieListInteractorProtocol? { get set }
    var router: MovieListRouterProtocol? { get set }

    func viewDidLoad()
    func willLoadMovies(page: Int)
    func willLoadGenres()
    func didTapInMovieCell(movie: MovieModel, isIpad: Bool)
}

protocol MovieListRouterProtocol: class {
    var viewController: UIViewController? { get set }

    func showMovieDetail(movie: MovieModel, isIpad: Bool)
    func showErrorAlert(error: Error)
}
