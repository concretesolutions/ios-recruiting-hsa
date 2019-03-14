import RxSwift

final class MovieListInteractor: MovieListInteractorProtocol {
    weak var delegate: MovieListInteractorDelegate?
    private let disposeBag = DisposeBag()

    private let savedMoviesRepository: SavedMoviesRepositoryProtocol
    private let movieDBRepository: MovieDBRepositoryProtocol
    private let configurations: ConfigurationsProtocol

    init(savedMoviesRepository: SavedMoviesRepositoryProtocol, movieDBRepository: MovieDBRepositoryProtocol, configurations: ConfigurationsProtocol) {
        self.savedMoviesRepository = savedMoviesRepository
        self.movieDBRepository = movieDBRepository
        self.configurations = configurations
    }

    func fetchMovies(page: Int, append: Bool) {
        movieDBRepository.getMovieList(configurations: configurations, page: page).subscribe { event in
            switch event {
            case let .success(movies):
                self.delegate?.fetchMoviesSuccess(movies: movies, append: append)
            case let .error(error):
                self.delegate?.fetchMoviesFail(error: error)
            }
        }.disposed(by: disposeBag)
    }

    func fetchGenres() {
        movieDBRepository.getGenreList(configurations: configurations).subscribe { event in
            switch event {
            case let .success(genres):
                self.delegate?.fetchGenresSuccess(genres: genres)
            case let .error(error):
                self.delegate?.fetchMoviesFail(error: error)
            }
        }.disposed(by: disposeBag)
    }

    func fetchSavedMoviesIds(append: Bool) {
        savedMoviesRepository.getMoviesIds().subscribe { event in
            switch event {
            case let .success(ids):
                self.delegate?.fetchSavedMoviesIdsSuccess(ids: ids, append: append)
            case let .error(error):
                self.delegate?.fetchGenresFail(error: error)
            }
        }.disposed(by: disposeBag)
    }
}
