//
//  Movie.swift
//  TMDB Reloaded
//
//  Created by Miguel Duran on 1/4/19.
//  Copyright © 2018 Miguel Duran. All rights reserved.
//

import Foundation

struct Movie {
    let voteCount, id: Int
    let video: Bool
    let voteAverage: Float
    let title: String
    let popularity: Float
    let posterPath, originalLanguage, originalTitle: String
    let genreIDS: [Int]
    let backdropPath: String
    let adult: Bool
    let overview: String
    let releaseDate: Date
}

extension Movie: Decodable {
    enum CodingKeys: String, CodingKey {
        case voteCount = "vote_count"
        case id, video
        case voteAverage = "vote_average"
        case title, popularity
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult, overview
        case releaseDate = "release_date"
    }
}
