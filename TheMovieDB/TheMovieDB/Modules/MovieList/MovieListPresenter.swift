class MovieListPresenter: MovieListPresenterProtocol {
    weak var view: MovieListViewProtocol?
    var interactor: MovieListInteractorProtocol?
    var router: MovieListRouterProtocol?

    convenience init(interactor: MovieListInteractorProtocol, router: MovieListRouterProtocol) {
        self.init()
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        view?.showLoading()
        interactor?.fetchMovies(page: 1, append: false)
        interactor?.fetchGenres()
        interactor?.fetchSavedMoviesIds(append: false)
    }

    func willLoadMovies(page: Int) {
        view?.showLoading()
        interactor?.fetchMovies(page: page, append: true)
    }

    func willLoadGenres() {
        interactor?.fetchGenres()
    }

    func didTapInMovieCell(movie: MovieModel, genres: [String], isIpad: Bool) {
        router?.showMovieDetail(movie: movie, genres: genres, isIpad: isIpad)
    }
}

extension MovieListPresenter: MovieListInteractorDelegate {
    func fetchMoviesSuccess(movies: [MovieModel], append: Bool) {
        view?.hideLoading()
        view?.setMovies(movies: movies, append: append)
    }

    func fetchMoviesFail(error: Error) {
        view?.hideLoading()
        router?.showErrorAlert(error: error)
    }

    func fetchGenresSuccess(genres: [GenreModel]) {
        view?.setGenres(genres: genres)
    }

    func fetchGenresFail(error: Error) {}

    func fetchSavedMoviesIdsSuccess(ids: [Int], append: Bool) {
        view?.hideLoading()
        view?.setSavedMoviesIds(ids: ids, append: append)
    }

    func fetchSavedMoviesIdsFail(error: Error) {
        view?.hideLoading()
        router?.showErrorAlert(error: error)
    }
}
