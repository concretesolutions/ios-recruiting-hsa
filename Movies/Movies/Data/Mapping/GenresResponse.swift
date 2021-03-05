//
//  GenresResponse.swift
//  Movies
//
//  Created by Daniel Nunez on 05-03-21.
//

import Foundation

// MARK: - GenresResponse

class GenreResponse: Codable {
    let genres: [Genre]?

    init(results: [Genre]?) {
        genres = results
    }
}

// MARK: - Genre

class Genre: Codable {
    let id: Int?
    let name: String?

    init(name: String?, id: Int?) {
        self.name = name
        self.id = id
    }
}
