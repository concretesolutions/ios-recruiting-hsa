//
//  GenreManager.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/31/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation

protocol GenreManager {
    func fetchGenres()
    func genreFor(id: Int) -> String?
}

func genreManagerDefault() -> GenreManager {
    return GenreManagerImpl(movieClient: movieClientDefault(), persistance: persistanceDefault())
}

// Implementation

class GenreManagerImpl {

    private let movieClient: MovieClient
    private let persistance: Persistance
    private var genresMap: [Int: String]

    init(movieClient: MovieClient, persistance: Persistance) {
        self.movieClient = movieClient
        self.persistance = persistance
        self.genresMap = [:]
    }
}

extension GenreManagerImpl: GenreManager {

    func fetchGenres() {
        let key = Constants.PersistanceKeys.genresMovies
        genresMap = (try? persistance.retreive(key: key)) ?? [:]
        movieClient.genres(
            onSuccess: { [weak self] response in
                var map: [Int: String] = [:]
                response.genres.forEach { map[$0.id] = $0.name }
                self?.genresMap = map
                try? self?.persistance.save(data: map, forKey: key)
            },
            onError: nil)
    }

    func genreFor(id: Int) -> String? {
        return genresMap[id] ?? ""
    }
}
