//
//  MoviesRepositoryMock.swift
//  Concrete-MoviesTests
//
//  Created by Audel Dugarte on 5/2/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import Foundation
@testable import Concrete_Movies

class MoviesRepositoryMock: MoviesRepository {
    var success = false
    var errorExists = false
    
    func popularMovies(completionHandler: @escaping ([SimpleMovie]?, Error?) -> Void) {
        if(success){
            let movie = SimpleMovie(posterPath: "", adult: true, overview: "", releaseDate: "", genres: [], movieId: 1, originalTitle: "", originalLanguage: "", title: "", backdropPath: "", popularity: 1, voteCount: 1, video: true, voteAverage: 1, isFavorited: true)
            completionHandler([movie], nil)
        }else{
            completionHandler(nil, nil)
        }
    }
    
    func movieDetail(movieId: String, completionHandler: @escaping (MovieDetails?, Error?) -> Void) {
        if(success){
            let movie = MovieDetails(genres: [""], homepage: "", movieId: 1, imdbId: "", originalLanguage: "", originalTitle: "", overview: "", popularity: 1.0, posterPath: "", releaseDate: "", runtime: 1, status: "", tagline: "", title: "", voteAverage: 1.0, voteCount: 1, isFavorited: true)
            completionHandler(movie, nil)
        }else{
            completionHandler(nil, nil)
        }
    }
    
    func favoritedMovies(completionHandler: @escaping ([FavoritedMovie]?, Error?) -> Void) {
        if(success){
            let movie = FavoritedMovie(name: "", movieId: 1, overview: "", posterPath: "", relaaseDate: "")
            completionHandler([movie], nil)
        }else{
            completionHandler(nil, nil)
        }
    }
    
    func saveFavorite(movie: FavoritedMovie) {
        //success = true
    }
    
    func deleteFavoriteMovie(with id: Int) {
        //success = true
    }
}
