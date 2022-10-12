//
//  Movie.swift
//  Concrete Challenge
//
//  Created by Jonathan Pacheco on 11/10/22.
//

import Foundation
import Redux

struct MoviesState: Redux.State {
    
    static var initialValue: MoviesState { MoviesState() }

    var isLoading: Bool = false
    var isError: Bool = false
    var canLoadMore: Bool = true
    var currentPage: Int = 0
    var canLoadMorePages: Bool = true
    
    var populars: [Movie] = []
    var genres: [Genre] = []
    var favorites: [Int] = []
}

struct Movie: Decodable, Equatable, Hashable {
    
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    var releaseYear: String {
        if let match = releaseDate.matches(of: /[\d]{4}/).first {
            return releaseDate[match.range.lowerBound..<match.range.upperBound].description
        }
        return releaseDate
    }
    
    static func ==(lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
}

struct Genre: Decodable, Equatable {
    let id: Int
    let name: String
}
