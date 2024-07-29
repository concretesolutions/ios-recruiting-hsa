//
//  FavoriteMovieLocalDataSourceImpl.swift
//  Movies
//
//  Created by Pedro on 23-07-24.
//

import Foundation
import Combine
import CoreData

class FavoriteMovieLocalDataSourceImpl: FavoriteMovieLocalDataSource {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = PersistenceController.shared.context) {
        self.context = context
    }

    func fetchFavorites() -> AnyPublisher<[FavoriteMovieEntity], Error> {
        return Future { [unowned self] promise in
            do {
                let fetchRequest = FavoriteMovieEntity.fetchRequest()
                let results = try context.fetch(fetchRequest)
                return promise(.success(results))
            } catch {
                return promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    func addFavorite(movie: Movie) -> AnyPublisher<Void, Error> {
        return Future { [unowned self] promise in
            do {
                let fetchRequest = FavoriteMovieEntity.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id == %d", movie.id)
                let result = try context.fetch(fetchRequest)
                let favoriteMovie = result.first ?? FavoriteMovieEntity(context: context)
                favoriteMovie.update(from: movie)
                try context.save()
                return promise(.success(()))
            } catch {
                return promise(.failure(error))
            }
        }.eraseToAnyPublisher()

    }
    
    func deleteFavorite(movie: Movie) -> AnyPublisher<Void, Error> {
        return Future { [unowned self] promise in
            do {
                let fetchRequest = FavoriteMovieEntity.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id == %d", movie.id)
                let results = try context.fetch(fetchRequest)
                if let movie = results.first {
                    context.delete(movie)
                    try context.save()
                    return promise(.success(()))
                } else {
                    throw FavoriteMovieLocalDataSourceError.notFound
                }
            } catch {
                return promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }

    func isFavorite(movie: Movie) -> AnyPublisher<Bool, any Error> {
        return Future { [unowned self] promise in
            do {
                let fetchRequest = FavoriteMovieEntity.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id == %d", movie.id)
                let results = try context.count(for: fetchRequest)
                return promise(.success(results > 0))
            } catch {
                return promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
}

enum FavoriteMovieLocalDataSourceError: Error {
    case notFound
}

extension FavoriteMovieEntity {
    var toDomain: Movie? {
        guard let title, let overview, let posterPath, let releaseDate, let genreIds else { return nil }
        return Movie(id: Int(id), title: title, overview: overview, posterPath: posterPath, releaseDate: releaseDate, genreIds: genreIds)
    }

    func update(from movie: Movie) {
        self.id = Int32(movie.id)
        self.title = movie.title
        self.overview = movie.overview
        self.posterPath = movie.posterPath
        self.releaseDate = movie.releaseDate
        self.genreIds = movie.genreIds
    }
}
