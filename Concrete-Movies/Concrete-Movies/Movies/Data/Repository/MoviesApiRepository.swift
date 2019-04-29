//
//  MoviesApiRepository.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/27/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import Foundation

class MoviesApiRepository: MoviesRepository {
    private let moviesApiDataSource: MoviesDataSource
    private let simpleMovieModelToEntityMapper: Mapper<SimpleMovie, SimpleMovieEntity>
    private let movieDetailModelToEntityMapper: Mapper<MovieDetails, MovieDetailEntity>
    
    init(
        moviesApiDataSource: MoviesDataSource,
        simpleMovieModelToEntityMapper: Mapper<SimpleMovie, SimpleMovieEntity>,
        movieDetailModelToEntityMapper: Mapper<MovieDetails, MovieDetailEntity>
        )
    {
        self.moviesApiDataSource = moviesApiDataSource
        self.simpleMovieModelToEntityMapper = simpleMovieModelToEntityMapper
        self.movieDetailModelToEntityMapper = movieDetailModelToEntityMapper
    }
    
    func popularMovies(completionHandler: @escaping ([SimpleMovie]?, Error?) -> Void) {
        moviesApiDataSource.popularMoviesEntity { (popularMoviesEntity, error) in
            if let popularMoviesEntity = popularMoviesEntity{
                completionHandler(self.simpleMovieModelToEntityMapper.reverseMap(values: popularMoviesEntity.results), nil)
            }else{
                completionHandler(nil, error)
            }
        }
    }
    
    func movieDetail(movieId: String, completionHandler: @escaping (MovieDetails?, Error?)->Void){
        moviesApiDataSource.movieDetailEntity(movieId: movieId) { (movieDetailEntity, error) in
            if let movieDetailEntity = movieDetailEntity{
                completionHandler(self.movieDetailModelToEntityMapper.reverseMap(value: movieDetailEntity), nil)
            }else{
                completionHandler(nil, error)
            }
        }
    }
    
}
