class MovieDetailPresenter: MovieDetailPresenterProtocol {
    weak var view: MovieDetailViewProtocol?
    var interactor: MovieDetailInteractorProtocol?
    var router: MovieDetailRouterProtocol?

    convenience init(interactor: MovieDetailInteractorProtocol, router: MovieDetailRouterProtocol) {
        self.init()
        self.interactor = interactor
        self.router = router
    }

    func didTapSaveButton(movie: MovieModel, isDelete: Bool) {
        view?.showLoading()
        if isDelete {
            interactor?.unsaveMovie(movie)
        } else {
            interactor?.saveMovie(movie)
        }
    }

    func viewDidLoad(movie: MovieModel?) {
        guard let movieId = movie?.id else { return }
        view?.showLoading()
        interactor?.fetchSavedStatus(movieId: movieId)
    }
}

extension MovieDetailPresenter: MovieDetailInteractorDelegate {
    func saveMovieSuccess() {
        view?.hideLoading()
        view?.updateSavedMovieStatus(saved: true)
    }

    func saveMovieFailure(error: Error) {
        view?.hideLoading()
        router?.showErrorAlert(error: error)
    }

    func unsaveMovieSuccess() {
        view?.hideLoading()
        view?.updateSavedMovieStatus(saved: false)
    }

    func unsaveMovieFailure(error: Error) {
        view?.hideLoading()
        router?.showErrorAlert(error: error)
    }

    func savedMovieStatusFetched(saved: Bool) {
        view?.hideLoading()
        view?.updateSavedMovieStatus(saved: saved)
    }
}
