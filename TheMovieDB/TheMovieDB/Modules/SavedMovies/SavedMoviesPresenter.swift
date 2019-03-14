class SavedMoviesPresenter: SavedMoviesPresenterProtocol {
    weak var view: SavedMoviesViewProtocol?
    var interactor: SavedMoviesInteractorProtocol?
    var router: SavedMoviesRouterProtocol?

    convenience init(interactor: SavedMoviesInteractorProtocol, router: SavedMoviesRouterProtocol) {
        self.init()
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        interactor?.fetchSavedMovies()
    }

    func willDeleteMovie(movieId: Int32) {
        view?.showLoading()
        interactor?.unsaveMovie(movieId: movieId)
    }

    func filterButtonTapped() {
        router?.showFilterView()
    }

    func didTapInMovieCell(movie: MovieModel, genres: [String], isIpad: Bool, savedAdsDelegate: MovieListSavedAdsUpdate?) {
        router?.showMovieDetail(movie: movie, genres: genres, isIpad: isIpad, savedAdsDelegate: savedAdsDelegate)
    }
}

extension SavedMoviesPresenter: SavedMoviesInteractorDelegate {
    func fetchSavedMoviesSuccess(savedMovies: [MovieModel]) {
        view?.hideLoading()
        view?.setMovies(savedMovies)
    }

    func fetchSavedMoviesFail(error: Error) {
        view?.hideLoading()
        router?.showErrorAlert(error: error)
    }

    func unsaveMovieSuccess() {
        view?.hideLoading()
        let message = SavedMoviesLocalizer.unsaveSuccessfull.localizedString
        view?.showMessage(message)
    }

    func unsaveMovieFail(error: Error) {
        view?.hideLoading()
        router?.showErrorAlert(error: error)
    }
}
