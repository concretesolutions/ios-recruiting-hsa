//
//  FavoritedMovieModelToEntityMapper.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/30/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import Foundation

class FavoritedMovieModelToEntityMapper: Mapper<FavoritedMovie, FavoritedMovieEntity> {
    override func reverseMap(value: FavoritedMovieEntity) -> FavoritedMovie {
        let movie = FavoritedMovie(
            name: value.name,
            movieId: value.movieId,
            overview: value.overview,
            posterPath: value.posterPath
        )
        return movie
    }
}
