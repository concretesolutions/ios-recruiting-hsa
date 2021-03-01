//
//  Genre.swift
//  MoviesApp
//
//  Created by Hector Morales on 2/28/21.
//

import Foundation

// MARK: - MovieResponse
class GenreResponse: Codable {
    let genres: [Genre]?

    init(results: [Genre]?) {
        self.genres = results
    }
}

// MARK: - Result
class Genre: Codable {
    let id: Int?
    let name: String?

    init(name: String?, id: Int?) {
        self.name = name
        self.id = id
    }
}
