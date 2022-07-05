//
//  MovieDetailResponse.swift
//  tmdb-app
//
//  Created by training on 03-07-22.
//

import Foundation

struct MovieDetailResponse: Codable {
    
    var pag: Int
    var results: [PopularMovie]?
    var totalPages: Int
    var totalResults: Int
    

}
