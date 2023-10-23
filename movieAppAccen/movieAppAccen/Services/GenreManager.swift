//
//  GenreManager.swift
//  movieAppAccen
//
//  Created by Orlando Velasco on 21-10-23.
//

import Foundation

class GenreManager {
    static let shared = GenreManager()
    
    var genres: [Genre] = []
    private let genreWorker = GenreWorker()
    
    private init() {}
    
    func fetchAndStoreGenres(completion: @escaping (Error?) -> Void) {
        genreWorker.fetchMovieGenres { fetchedGenres, error in
            if let fetchedGenres = fetchedGenres {
                self.genres = fetchedGenres
                completion(nil)
            } else if let error = error {
                completion(error)
            }
        }
    }
    
    func genre(forID id: Int) -> Genre? {
        return genres.first { $0.id == id }
    }
}

