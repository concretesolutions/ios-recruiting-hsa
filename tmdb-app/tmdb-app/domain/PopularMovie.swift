//
//  PopularMovie.swift
//  tmdb-app
//
//  Created by training on 30-06-22.
//

import Foundation

/**
 Dominio de películas populares
 */
struct PopularMovie: Codable {
    
    var adult: Bool
    var backdropPath: String?
    var genreIds: [Int]?
    var id: Int
    var originalLanguage: String?
    var originalTitle: String?
    var overview: String?
    var popularity: Double?
    var posterPath: String?
    var releaseDate: String?
    var video: Bool
    var title: String
    var voteAverage: Float
    var voteCount: Int
    
}
