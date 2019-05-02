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
                let moviesModel = self.simpleMovieModelToEntityMapper.reverseMap(values: popularMoviesEntity.results)
                self.setFavoriteMovies(movies: moviesModel, favorited: [])
                completionHandler(moviesModel, nil)
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
    
    func saveFavorite(movie: FavoritedMovie) {
        localDBMoviesDataSource.saveFavorited(movie: favoritedMovieModelToEntityMapper.map(value: movie))
    }
    
    func deleteFavoriteMovie(with id: Int) {
        localDBMoviesDataSource.deleteFavoriteMovie(with: id)
    }
    
    private func setFavoriteMovies(movies: [SimpleMovie], favorited: [FavoritedMovie])->Void{
        /*
        for movie in movies{
            if favorited.contains(where: { return $0.movieId == movie.movieId }){
                movie.isFavorited = true
            }
            if(movie.movieId > 200){
                movie.isFavorited = true
            }
        }
         */
        
        let modifiedMovies = movies.map { (simpleMovie) -> SimpleMovie in
            var realFav = false
            if favorited.contains(where: { return $0.movieId == simpleMovie.movieId }){
                realFav = true
            }
            
            let movie = SimpleMovie(
                posterPath: simpleMovie.posterPath,
                adult: simpleMovie.adult,
                overview: simpleMovie.overview,
                releaseDate: simpleMovie.releaseDate,
                genres: simpleMovie.genres,
                movieId: simpleMovie.movieId,
                originalTitle: simpleMovie.originalTitle,
                originalLanguage: simpleMovie.originalLanguage,
                title: simpleMovie.title,
                backdropPath: simpleMovie.backdropPath,
                popularity: simpleMovie.popularity,
                voteCount: simpleMovie.voteCount,
                video: simpleMovie.video,
                voteAverage: simpleMovie.voteAverage,
                isFavorited: realFav)
            return movie
        }
        print("\n\n ##################################### \n\n")
        print(modifiedMovies)
        print("\n\n ##################################### \n\n")
    }
}
