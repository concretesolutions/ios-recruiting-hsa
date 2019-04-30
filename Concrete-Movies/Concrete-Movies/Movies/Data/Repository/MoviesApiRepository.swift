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
    private let favoritedMovieModelToEntityMapper: Mapper<FavoritedMovie, FavoritedMovieEntity>
    
    private let localDBMoviesDataSource: LocalMoviesDataSource
    
    init(
        moviesApiDataSource: MoviesDataSource,
        simpleMovieModelToEntityMapper: Mapper<SimpleMovie, SimpleMovieEntity>,
        movieDetailModelToEntityMapper: Mapper<MovieDetails, MovieDetailEntity>,
        localDBMoviesDataSource: LocalMoviesDataSource,
        favoritedMovieModelToEntityMapper: Mapper<FavoritedMovie, FavoritedMovieEntity>
        )
    {
        self.moviesApiDataSource = moviesApiDataSource
        self.simpleMovieModelToEntityMapper = simpleMovieModelToEntityMapper
        self.movieDetailModelToEntityMapper = movieDetailModelToEntityMapper
        self.localDBMoviesDataSource = localDBMoviesDataSource
        self.favoritedMovieModelToEntityMapper = favoritedMovieModelToEntityMapper
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
    
    func favoritedMovies(completionHandler: @escaping ([FavoritedMovie]?, Error?)->Void){
        localDBMoviesDataSource.favoritedMoviesEntity { (favoritedMovies, error) in
            if let favoritedMovies = favoritedMovies{
                let modelMovies = self.favoritedMovieModelToEntityMapper.reverseMap(values: favoritedMovies)
                completionHandler(modelMovies, nil)
            }else{
                completionHandler(nil, error)
            }
        }
    }
    
    private func setFavoriteMovies(movies: [SimpleMovie], favorited: [FavoritedMovie])->Void{
        for movie in movies{
            if favorited.contains(where: { return $0.movieId == movie.movieId }){
                //movie.isFavorited = true
            }
        }
    }
}
