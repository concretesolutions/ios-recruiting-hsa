//
//  MovieDetailsModelToEntityMapper.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/28/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import Foundation

class MovieDetailsModelToEntityMapper: Mapper<MovieDetails, MovieDetailEntity> {
    override func reverseMap(value: MovieDetailEntity) -> MovieDetails {
        let movieDetail = MovieDetails(
            genres: justGenresNames(genreEntities: value.genres),
            homepage: value.homepage,
            movieId: value.movieId,
            imdbId: value.imdbId,
            originalLanguage: value.originalLanguage,
            originalTitle: value.originalTitle,
            overview: value.overview,
            popularity: value.popularity,
            posterPath: value.posterPath,
            releaseDate: value.releaseDate,
            runtime: value.runtime,
            status: value.status,
            tagline: value.tagline,
            title: value.title,
            voteAverage: value.voteAverage,
            voteCount: value.voteCount,
            isFavorited: false
        )
        return movieDetail
    }
    
    private func justGenresNames(genreEntities: [GenreEntity])->[String]{
        return genreEntities.map({ $0.name })
    }
}
