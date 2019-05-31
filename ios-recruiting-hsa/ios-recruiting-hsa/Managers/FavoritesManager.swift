//
//  ApplicationManager.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/31/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation

protocol FavoritesManager: class {

    var getFavouritesMovies: AnySequence<PopularMovie> { get }

    /// This method adds a movie to the current application. It does nothing if the movie is already
    /// present
    func addNewMovie(movie: PopularMovie)

    /// This method removes a movie to the current application. It does nothing if the movie is
    /// already present.
    func remove(movie: PopularMovie)
}

func favoritesManagerDefault() -> FavoritesManager {
    return FavoritesManagerImpl(persistance: persistanceDefault())
}

// Implementation

class FavoritesManagerImpl {

    let persistance: Persistance
    let queue = DispatchQueue(label: "applicationManager", qos: .userInteractive)

    private lazy var favoritesMovies: Set<PopularMovie> = {
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

    var getFavouritesMovies: AnySequence<PopularMovie> { return AnySequence(favoritesMovies) }

    func addNewMovie(movie: PopularMovie) {
        queue.sync {
            self.favoritesMovies.insert(movie)
            try? self.persistance.save(data: self.favoritesMovies, forKey: self.key)
        }
    }

    /// This method removes a movie to the current application. It does nothing if the movie is
    /// already present.
    func remove(movie: PopularMovie) {
        queue.sync {
            self.favoritesMovies.remove(movie)
            try? self.persistance.save(data: self.favoritesMovies, forKey: self.key)
        }
    }
}
