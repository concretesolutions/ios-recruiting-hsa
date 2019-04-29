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
    
    init(
        moviesApiDataSource: MoviesDataSource,
        simpleMovieModelToEntityMapper: Mapper<SimpleMovie, SimpleMovieEntity>
        )
    {
        self.moviesApiDataSource = moviesApiDataSource
        self.simpleMovieModelToEntityMapper = simpleMovieModelToEntityMapper
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
    
}
