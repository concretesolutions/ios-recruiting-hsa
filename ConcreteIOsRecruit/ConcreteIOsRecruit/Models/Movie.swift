//
//  Movie.swift
//  ConcreteIOsRecruit
//
//  Created by Matías Contreras Selman on 11/18/18.
//  Copyright © 2018 Matias Contreras. All rights reserved.
//

import Foundation

struct MoviesAPIResponse: Codable, Storable{
    var key: DataManager.StoringKey = .moviesAPIResponse
    
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

struct Movie: Codable, Equatable {
    
    //server properties
    let id : Int
    let voteCount: Int
    let video: Bool
    let voteAverage: Double
    let title: String
    let popularity: Double
    let posterPath: String
    let originalTitle: String
    let genreIDS: [Int]
    let backdropPath: String
    let adult: Bool
    let overview: String
    let releaseDate: String
    
    //custom defined properties
    let posterOriginUrl: String = "http://image.tmdb.org/t/p/w500"
    var isFavorite : Bool = false
    var fullImageUrl : URL {
        return URL(string: "\(posterOriginUrl)\(posterPath)")!
    }
    
    static func ==(lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
    
    enum CodingKeys: String, CodingKey {
        case id =               "id"
        case voteCount =        "vote_count"
        case video =            "video"
        case voteAverage =      "vote_average"
        case title =            "title"
        case popularity =       "popularity"
        case posterPath =       "poster_path"
        case originalTitle =    "original_title"
        case genreIDS =         "genre_ids"
        case backdropPath =     "backdrop_path"
        case adult =            "adult"
        case overview =         "overview"
        case releaseDate =      "release_date"
    }
    
}

