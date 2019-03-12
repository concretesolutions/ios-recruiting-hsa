import CoreData
import Foundation
import RxSwift

protocol SavedMoviesDataSourceProtocol {
    func storeMovie(model: MovieModel) -> Completable
    func deleteMovie(id: Int) -> Completable
    func getMovie(id: Int) -> Single<SavedMovie>
    func getMovies() -> Single<[SavedMovie]>
    func getMoviesIds() -> Single<[Int]>
}

class SavedMoviesDataSource: SavedMoviesDataSourceProtocol {
    private let persistentContainer: NSPersistentContainer
    private let entityName = "SavedMovie"

    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }

    func storeMovie(model: MovieModel) -> Completable {
        return Completable.create { completable in
            self.persistentContainer.performBackgroundTask { privateManagedObjectContext in
                let savedMovie = SavedMovie(context: privateManagedObjectContext)
                savedMovie.id = Int32(model.id)
                savedMovie.voteAverage = model.voteAverage
                savedMovie.title = model.title
                savedMovie.posterPath = model.posterPath
                savedMovie.genresId = model.genreIDS
                savedMovie.overview = model.overview
                savedMovie.releaseDate = model.releaseDate
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

    func deleteMovie(id: Int) -> Completable {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)

        return Completable.create { completable in
            self.persistentContainer.performBackgroundTask { privateManagedObjectContext in
                guard let firstResult = try? privateManagedObjectContext.fetch(fetchRequest).first, let savedMovie = firstResult as? SavedMovie else {
                    completable(.error(SavedAdsSourceError.noResults))
                    return
                }
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

    func getMovie(id: Int) -> Single<SavedMovie> {
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
