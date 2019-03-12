class MovieDetailPresenter: MovieDetailPresenterProtocol {
    var view: MovieDetailViewProtocol?
    var interactor: MovieDetailInteractorProtocol?
    var router: MovieDetailRouterProtocol?

    convenience init(interactor: MovieDetailInteractorProtocol, router: MovieDetailRouterProtocol) {
        self.init()
        self.interactor = interactor
        self.router = router
    }

    func didTapSaveButton(movie: MovieModel, isDelete: Bool) {}
}

extension MovieDetailPresenter: MovieDetailInteractorDelegate {
    func saveMovieSuccess() {}

    func saveMovieFailure(error: Error) {}

    func unsaveMovieSuccess() {}

    func unsaveMovieFailure() {}
}
