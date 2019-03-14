import RxSwift

final class SavedMoviesInteractor: SavedMoviesInteractorProtocol {
    weak var delegate: SavedMoviesInteractorDelegate?
    private let savedMoviesRepository: SavedMoviesRepositoryProtocol
    private let disposeBag = DisposeBag()

    init(savedMoviesRepository: SavedMoviesRepositoryProtocol) {
        self.savedMoviesRepository = savedMoviesRepository
    }

    func fetchSavedMovies() {
        savedMoviesRepository.getMovies().subscribe { event in
            switch event {
            case let .success(movies):
                self.delegate?.fetchSavedMoviesSuccess(savedMovies: movies)
            case let .error(error):
                self.delegate?.fetchSavedMoviesFail(error: error)
            }
        }.disposed(by: disposeBag)
    }

    func unsaveMovie(movieId: Int32) {
        savedMoviesRepository.deleteMovie(with: movieId).subscribe { event in
            switch event {
            case .completed:
                self.delegate?.unsaveMovieSuccess(movieId: movieId)
            case let .error(error):
                self.delegate?.unsaveMovieFail(error: error)
            }
        }.disposed(by: disposeBag)
    }
}
