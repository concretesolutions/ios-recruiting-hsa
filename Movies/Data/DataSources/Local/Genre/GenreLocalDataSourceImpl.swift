//
//  GenreLocalDataSourceImpl.swift
//  Movies
//
//  Created by Pedro on 26-07-24.
//

import Foundation
import Combine
import CoreData

class GenreLocalDataSourceImpl: GenreLocalDataSource {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = PersistenceController.shared.context) {
        self.context = context
    }

    func save(genres: [Genre]) -> AnyPublisher<Void, Error> {
        return Future { [unowned self] promise in
            do {
                for genre in genres {
                    let fetch = GenreEntity.fetchRequest()
                    fetch.predicate = NSPredicate(format: "id == %d", genre.id)
                    let results = try context.fetch(fetch)
                    let genreEntity = results.first ?? GenreEntity(context: context)
                    genreEntity.update(from: genre)
                }
                try context.save()
                return promise(.success(()))
            } catch {
                return promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    func getGenres() -> AnyPublisher<[GenreEntity], Error> {
        return Future { [unowned self] promise in
            do {
                let fetchRequest = GenreEntity.fetchRequest()
                let results = try context.fetch(fetchRequest)
                return promise(.success(results))
            } catch {
                return promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    func getGenres(by ids: [Int]) -> AnyPublisher<[GenreEntity], Error> {
        return Future { [unowned self] promise in
            do {
                let fetchRequest = GenreEntity.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id IN %@", ids)
                let results = try context.fetch(fetchRequest)
                return promise(.success(results))
            } catch {
                return promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
}

extension GenreEntity {
    var toDomain: Genre? {
        guard let name else { return nil }
        return Genre(id: Int(id), name: name)
    }

    func update(from genre: Genre) {
        self.id = Int32(genre.id)
        self.name = genre.name
    }
}
