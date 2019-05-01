//
//  FavoritedMovieViewModelToModelMapper.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 5/1/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import Foundation

class FavoritedMovieViewModelToModelMapper: Mapper<FavoritedMovieViewModel, FavoritedMovie> {
    override func reverseMap(value: FavoritedMovie) -> FavoritedMovieViewModel {
        let viewModel = FavoritedMovieViewModel(
            name: value.name,
            movieId: value.movieId,
            overview: value.overview,
            posterPath: value.posterPath,
            releaseYear: value.relaaseDate
        )
        
        return viewModel
    }
    
    override func map(value: FavoritedMovieViewModel) -> FavoritedMovie {
        let model = FavoritedMovie(
            name: value.name,
            movieId: value.movieId,
            overview: value.overview,
            posterPath: value.posterPath,
            relaaseDate: value.releaseYear
        )
        
        return model
    }
}
