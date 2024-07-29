//
//  MovieUrlProvider.swift
//  Movies
//
//  Created by Pedro on 28-07-24.
//

import Foundation

struct MovieUrlProvider {
    static func to(_ movie: Movie) -> URL? {
        #if SNAPSHOT_TEST
        Bundle.main.url(forResource: "movie-placeholder", withExtension: "png")
        #else
        URL(string: Constants.MOVIEDBIMAGEURL + "\(movie.posterPath)")
        #endif
    }
}
