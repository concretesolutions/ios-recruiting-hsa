//
//  PopularMoviesResultEntity.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/28/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

struct PopularMoviesResultEntity: Codable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [SimpleMovieEntity]
    
    private enum CodingKeys: String, CodingKey{
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}
