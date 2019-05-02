//
//  MovieDetailsViewModel.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/28/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import Foundation

struct MovieDetailsViewModel{
    let genres: [String]
    let homepage: String
    let movieId: Int
    let imdbId: String
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Float
    let posterPath: String
    let releaseDate: String
    let runtime: Int
    let status: String
    let tagline: String
    let title: String
    let voteAverage: Float
    let voteCount: Int
    
    let isFavorited: Bool
}
