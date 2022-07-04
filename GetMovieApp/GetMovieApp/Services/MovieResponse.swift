//
//  MovieResponse.swift
//  GetMovieApp
//
//  Created by Training on 03-07-22.
//

import Foundation


struct MovieResponse: Codable {
    //MARK: Propierties
    let page: Int
    let results: [ResultMovieResponse]
    let total_pages, total_results: Int
}

struct ResultMovieResponse: Codable {
    
    //MARK: Propierties
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int?
    let originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    //MARK: CodingKeys
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
