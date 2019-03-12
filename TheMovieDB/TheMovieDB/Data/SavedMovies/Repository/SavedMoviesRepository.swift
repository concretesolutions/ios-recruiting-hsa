import Foundation
import RxSwift


protocol SavedMoviesRepositoryProtocol {
    func store(movieEntity: MovieModel) -> Completable
    func delete(movieId: Int) -> Completable
    func getMovies() -> Single<[MovieModel]>
    func getMoviesIds() -> Single<[Int]>
}
