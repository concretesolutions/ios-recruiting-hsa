import Foundation
import RxSwift

protocol SavedMoviesRepositoryProtocol {
    func storeMovie(model: MovieModel) -> Completable
    func deleteMovie(with movieId: Int) -> Completable
    func getMovies() -> Single<[MovieModel]>
    func getMoviesIds() -> Single<[Int]>
    func movieExists(movieId: Int) -> Completable
}

class SavedMoviesRepository: SavedMoviesRepositoryProtocol {
    private let dataSource: SavedMoviesDataSourceProtocol

    init(dataSource: SavedMoviesDataSourceProtocol) {
        self.dataSource = dataSource
    }

    func storeMovie(model: MovieModel) -> Completable {
        return dataSource.storeMovie(model: model)
    }

    func deleteMovie(with movieId: Int) -> Completable {
        return dataSource.deleteMovie(id: movieId)
    }

    func getMovies() -> Single<[MovieModel]> {
        return dataSource.getMovies().flatMap { (savedMovies) -> Single<[MovieModel]> in
            .just(savedMovies.compactMap({ MovieModel(savedMovie: $0) }))
        }
    }

    func getMoviesIds() -> Single<[Int]> {
        return dataSource.getMoviesIds()
    }

    func movieExists(movieId: Int) -> Completable {
        return dataSource.getMovie(id: movieId).flatMapCompletable({ (_) -> Completable in
            .empty()
        }).catchError({ (error) -> Completable in
            .error(error)
        })
    }
}
