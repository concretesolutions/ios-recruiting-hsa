//
//  ApplicationManager.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/31/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation

protocol FavoritesManager: class {

    var getFavouritesMovies: [PopularMovie] { get }

    /// This method adds a movie to the current application. It does nothing if the movie is already
    /// present
    func add(movie: PopularMovie)

    /// This method removes a movie to the current application. It does nothing if the movie is
    /// already present.
    func remove(movie: PopularMovie)

    /// Check if the passed movie is favorited
    func isFavorite(movie: PopularMovie) -> Bool
}

func favoritesManagerDefault() -> FavoritesManager {
    return FavoritesManagerImpl(persistance: persistanceDefault())
}

// Implementation

class FavoritesManagerImpl {

    let persistance: Persistance
    let queue = DispatchQueue(label: "applicationManager", qos: .userInteractive)

    private lazy var fastCheckfavoritesMovies: Set<PopularMovie> = Set(favoritesMovies)
    private lazy var favoritesMovies: [PopularMovie] = {
        return (try? persistance.retreive(key: key)) ?? []
    }()

    init(persistance: Persistance) {
        self.persistance = persistance
    }

}

private extension FavoritesManagerImpl {

    var key: String { return Constants.PersistanceKeys.favoritesMovies }
}

extension FavoritesManagerImpl: FavoritesManager {

    var getFavouritesMovies: [PopularMovie] { return favoritesMovies }

    func add(movie: PopularMovie) {
        queue.sync {
            let result = self.fastCheckfavoritesMovies.insert(movie)
            if result.inserted {
                self.favoritesMovies.append(movie)
                try? self.persistance.save(data: self.favoritesMovies, forKey: self.key)
            }
        }
    }

    func remove(movie: PopularMovie) {
        queue.sync {
            if let movie = self.fastCheckfavoritesMovies.remove(movie) {
                self.favoritesMovies.removeAll { $0 == movie }
                try? self.persistance.save(data: self.favoritesMovies, forKey: self.key)
            }
        }
    }

    func isFavorite(movie: PopularMovie) -> Bool {
        return fastCheckfavoritesMovies.contains(movie)
    }
}
