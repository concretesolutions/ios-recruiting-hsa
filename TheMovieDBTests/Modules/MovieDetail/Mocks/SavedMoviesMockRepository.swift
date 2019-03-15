import Foundation
import RxSwift
@testable import TheMovieDB

class SavedMoviesMockRepository: SavedMoviesRepositoryProtocol {
    private let status: MockStatus

    init(status: MockStatus) {
        self.status = status
    }

    func storeMovie(model _: MovieModel) -> Completable {
        switch status {
        case .success:
            return .empty()
        default:
            return .error(SavedMoviesMockRepositoryError.mockError)
        }
    }

    func deleteMovie(with _: Int32) -> Completable {
        switch status {
        case .success:
            return .empty()
        default:
            return .error(SavedMoviesMockRepositoryError.mockError)
        }
    }

    func getMovies() -> Single<[MovieModel]> {
        switch status {
        case .success:
            return .just([])
        default:
            return .error(SavedMoviesMockRepositoryError.mockError)
        }
    }

    func getMoviesIds() -> Single<[Int32]> {
        switch status {
        case .success:
            return .just([])
        default:
            return .error(SavedMoviesMockRepositoryError.mockError)
        }
    }

    func movieExists(movieId _: Int32) -> Completable {
        switch status {
        case .success:
            return .empty()
        default:
            return .error(SavedMoviesMockRepositoryError.mockError)
        }
    }
}

enum SavedMoviesMockRepositoryError: Error {
    case mockError
}
