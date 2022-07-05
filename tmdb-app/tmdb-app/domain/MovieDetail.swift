//
//  MovieDetail.swift
//  tmdb-app
//
//  Created by training on 02-07-22.
//

import Foundation

/**
 Dominio de películas
 */
struct MovieDetail: Codable {
    
    var id: Int?
    var backdropPath: String?
    var genres: [Genre]?
    var originalTitle: String?
    var overview: String?
    var popularity: Double?
    var posterPath: String?
    var releaseDate: String?
    var video: Bool?
    var title: String?
    var voteAverage: Float?
    var voteCount: Int?
    
}
