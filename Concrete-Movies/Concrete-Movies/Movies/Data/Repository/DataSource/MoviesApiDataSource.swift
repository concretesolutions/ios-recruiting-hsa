//
//  MoviesApiDataSource.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/27/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

class MoviesApiDataSource: MoviesDataSource{
    private let moviesRestApi: MoviesRestApi
    
    init(moviesRestApi: MoviesRestApi) {
        self.moviesRestApi = moviesRestApi
    }
    
    func popularMoviesEntity(completionHandler: @escaping (PopularMoviesResultEntity?, Error?) -> Void) {
        moviesRestApi.popularMoviesEntity { (popularMoviesEntity, error) in
            completionHandler(popularMoviesEntity, error)
        }
    }
    
    func movieDetailEntity(movieId: String, completionHandler: @escaping (MovieDetailEntity?, Error?)->Void){
        moviesRestApi.movieDetailEntity(movieId: movieId) { (movieDetailEntity, error) in
            completionHandler(movieDetailEntity, error)
        }
    }
}
