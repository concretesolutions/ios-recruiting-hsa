final class MovieDetailInteractor: MovieDetailInteractorProtocol {
    func saveMovie(_ movie: MovieModel) {}

    func unsaveMovie(_ movie: MovieModel) {}

    weak var delegate: MovieDetailInteractorDelegate?
}
