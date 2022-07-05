//
//  PopularMovieResponse.swift
//  tmdb-app
//
//  Created by training on 30-06-22.
//

import Foundation

struct PopularMovieResponse: Codable {
    
    var page: Int
    var results: [PopularMovie]?
    var totalPages: Int
    var totalResults: Int
    

}
