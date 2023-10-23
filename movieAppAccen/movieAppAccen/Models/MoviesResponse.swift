//
//  MovieResponse.swift
//  movieAppAccen
//
//  Created by Orlando Velasco on 20-10-23.
//

import Foundation

struct MoviesResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

