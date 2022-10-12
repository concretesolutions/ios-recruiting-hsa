//
//  AppActions.swift
//  Yuno Demo
//
//  Created by Jonathan Pacheco on 26/09/22.
//

import Foundation
import Redux

enum Actions {
    
    struct LoadPopularMovieList: Action {}
    struct ReceivePopularMoviesList: Action {
        let movies: [Movie]
        let isError: Bool
        
        init(movies: [Movie] = [], isError: Bool = false) {
            self.movies = movies
            self.isError = isError
        }
    }
    struct LoadGenreList: Action {}
    struct ReceiveGenreList: Action {
        let genres: [Genre]
    }
    
    struct ToggleMovieToFavorites: Action {
        let movieId: Int
    }
    struct LoadFavoriteMovies: Action {}
    struct ReceiveFavoriteMovies: Action {
        let movieIds: [Int]
    }
}
