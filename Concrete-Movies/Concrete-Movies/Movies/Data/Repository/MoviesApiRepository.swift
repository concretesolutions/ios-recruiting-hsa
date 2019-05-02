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
                self.localDBMoviesDataSource.favoritedMoviesEntity(completionHandler: { (favMovies, error) in
                    if let favMoviesEntity = favMovies{
                        let favoritedMovies = self.favoritedMovieModelToEntityMapper.reverseMap(values: favMoviesEntity)
                        completionHandler(
                            self.setFavoriteMovies(movies: moviesModel, favorited: favoritedMovies),
                            nil
                        )
                    }else{
                        completionHandler(nil, error)
                    }
                })
            }else{
                completionHandler(nil, error)
            }
        }
    }
    
    func movieDetail(movieId: String, completionHandler: @escaping (MovieDetails?, Error?)->Void){
        moviesApiDataSource.movieDetailEntity(movieId: movieId) { (movieDetailEntity, error) in
            if let movieDetailEntity = movieDetailEntity{
                let movieModel = self.movieDetailModelToEntityMapper.reverseMap(value: movieDetailEntity)
                self.localDBMoviesDataSource.favoritedMoviesEntity(completionHandler: { (favMovies, error) in
                    if let favMovies = favMovies{
                        completionHandler(
                            self.setMovieDetailsFavorited(
                                movie: movieModel,
                                favorited: self.favoritedMovieModelToEntityMapper.reverseMap(values: favMovies)
                            ),
                            nil
                        )
                    }else{
                        completionHandler(nil, error)
                    }
                })
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
    
    private func setFavoriteMovies(movies: [SimpleMovie], favorited: [FavoritedMovie])->[SimpleMovie]{
        
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
        
        return modifiedMovies
    }
    
    private func setMovieDetailsFavorited(movie: MovieDetails, favorited: [FavoritedMovie])->MovieDetails{
        let movieMod = MovieDetails(
            genres: movie.genres,
            homepage: movie.homepage,
            movieId: movie.movieId,
            imdbId: movie.imdbId,
            originalLanguage: movie.originalLanguage,
            originalTitle: movie.originalTitle,
            overview: movie.overview,
            popularity: movie.popularity,
            posterPath: movie.posterPath,
            releaseDate: movie.releaseDate,
            runtime: movie.runtime,
            status: movie.status,
            tagline: movie.tagline,
            title: movie.title,
            voteAverage: movie.voteAverage,
            voteCount: movie.voteCount,
            isFavorited: favorited.contains(where: { $0.movieId == movie.movieId })
        )
        
        return movieMod
    }
}
