import CoreData
import Foundation
import RxSwift

protocol SavedMoviesDataSourceProtocol {
    func store(movieEntity: MovieEntity) -> Completable
    func delete(savedMovie: SavedMovie) -> Completable
    func getSavedMovie(id: Int) -> Single<SavedMovie>
    func getMovies() -> Single<[SavedMovie]>
    func getMoviesIds() -> Single<[Int]>
}

class SavedMoviesDataSource: SavedMoviesDataSourceProtocol {
    private let persistentContainer: NSPersistentContainer
    private let entityName = "SavedMovie"

    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }

    func store(movieEntity: MovieEntity) -> Completable {
        return Completable.create { completable in
            self.persistentContainer.performBackgroundTask { privateManagedObjectContext in
                let savedMovie = SavedMovie(context: privateManagedObjectContext)
                savedMovie.voteCount = Int32(movieEntity.voteCount ?? 0)
                savedMovie.id = Int32(movieEntity.id ?? 0)
                savedMovie.video = movieEntity.video ?? false
                savedMovie.voteAverage = movieEntity.voteAverage ?? 0
                savedMovie.title = movieEntity.title
                savedMovie.popularity = movieEntity.popularity ?? 0
                savedMovie.posterPath = movieEntity.posterPath
                savedMovie.originalLanguage = movieEntity.originalLanguage
                savedMovie.originalTitle = movieEntity.originalTitle
                savedMovie.genresId = movieEntity.genreIDS
                savedMovie.backdropPath = movieEntity.backdropPath
                savedMovie.adult = movieEntity.adult ?? false
                savedMovie.overview = movieEntity.overview
                savedMovie.releaseDate = movieEntity.releaseDate
                do {
                    try privateManagedObjectContext.save()
                    completable(.completed)
                } catch {
                    completable(.error(error))
                }
            }
            return Disposables.create()
        }
    }

    func delete(savedMovie: SavedMovie) -> Completable {
        return Completable.create { completable in
            self.persistentContainer.performBackgroundTask { privateManagedObjectContext in
                do {
                    privateManagedObjectContext.delete(savedMovie)
                    try privateManagedObjectContext.save()
                    completable(.completed)
                } catch {
                    completable(.error(error))
                }
            }
            return Disposables.create()
        }
    }

    func getSavedMovie(id: Int) -> Single<SavedMovie> {
        let privateManagedObjectContext = persistentContainer.newBackgroundContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)

        return Single.create { single in
            let asynchronousFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { asynchronousFetchResult in
                guard let result = asynchronousFetchResult.finalResult as? [SavedMovie], let element = result.first else {
                    single(.error(SavedAdsSourceError.noResults))
                    return
                }
                single(.success(element))
            }
            do {
                try privateManagedObjectContext.execute(asynchronousFetchRequest)
            } catch {
                single(.error(error))
            }
            return Disposables.create()
        }
    }

    func getMovies() -> Single<[SavedMovie]> {
        let privateManagedObjectContext = persistentContainer.newBackgroundContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)

        return Single.create { single in
            let asynchronousFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { asynchronousFetchResult in
                guard let result = asynchronousFetchResult.finalResult as? [SavedMovie] else {
                    single(.error(SavedAdsSourceError.noResults))
                    return
                }
                single(.success(result))
            }
            do {
                try privateManagedObjectContext.execute(asynchronousFetchRequest)
            } catch {
                single(.error(error))
            }
            return Disposables.create()
        }
    }

    func getMoviesIds() -> Single<[Int]> {
        let result = getMovies().flatMap { (movies) -> Single<[Int]> in
            return .just(movies.compactMap({ Int($0.id) }))
        }
        return result
    }
}

enum SavedAdsSourceError: Error {
    case noResults, notSafeObject
}
