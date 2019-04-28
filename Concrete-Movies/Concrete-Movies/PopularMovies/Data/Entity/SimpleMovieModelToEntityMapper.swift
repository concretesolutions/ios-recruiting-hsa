//
//  SimpleMovieModelToEntityMapper.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/28/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import Foundation

class SimpleMovieModelToEntityMapper: Mapper<SimpleMovie, SimpleMovieEntity> {
    override func reverseMap(value: SimpleMovieEntity) -> SimpleMovie {
        let movie = SimpleMovie(
            posterPath: value.posterPath,
            adult: value.adult,
            overview: value.overview,
            releaseDate: value.releaseDate,
            genres: value.genreIds,
            movieId: value.movieId,
            originalTitle: value.originalTitle,
            originalLanguage: value.originalLanguage,
            title: value.title,
            backdropPath: value.backdropPath,
            popularity: value.popularity,
            voteCount: value.voteCount,
            video: value.video,
            voteAverage: value.voteAverage
        )
        return movie
    }
}
