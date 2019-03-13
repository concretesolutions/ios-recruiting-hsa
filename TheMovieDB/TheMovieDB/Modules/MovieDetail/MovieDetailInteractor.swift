import RxSwift

final class MovieDetailInteractor: MovieDetailInteractorProtocol {
    weak var delegate: MovieDetailInteractorDelegate?
    private let repository: SavedMoviesRepositoryProtocol
    private let disposeBag = DisposeBag()

    init(repository: SavedMoviesRepositoryProtocol) {
        self.repository = repository
    }

    func saveMovie(_ movie: MovieModel) {
        repository.storeMovie(model: movie).subscribe { event in
            switch event {
            case .completed:
                self.delegate?.saveMovieSuccess()
            case let .error(error):
                self.delegate?.saveMovieFailure(error: error)
            }
        }.disposed(by: disposeBag)
    }

    func unsaveMovie(_ movie: MovieModel) {
        repository.deleteMovie(with: movie.id).subscribe { event in
            switch event {
            case .completed:
                self.delegate?.unsaveMovieSuccess()
            case let .error(error):
                self.delegate?.unsaveMovieFailure(error: error)
            }
        }.disposed(by: disposeBag)
    }

    func fetchSavedStatus(movieId: Int) {
        repository.movieExists(movieId: movieId).subscribe { event in
            switch event {
            case .completed:
                self.delegate?.savedMovieStatusFetched(saved: true)
            case .error:
                self.delegate?.savedMovieStatusFetched(saved: false)
            }
        }.disposed(by: disposeBag)
    }
}
