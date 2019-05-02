//
//  SimpleMovieViewModelToModelMapper.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/28/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import Foundation

class SimpleMovieViewModelToModelMapper: Mapper<SimpleMovieViewModel,SimpleMovie> {
    override func reverseMap(value: SimpleMovie) -> SimpleMovieViewModel {
        let viewModel = SimpleMovieViewModel(
            posterPath: value.posterPath,
            adult: value.adult,
            overview: value.overview,
            releaseDate: value.releaseDate.components(separatedBy: "-").first ?? " ",
            genres: value.genres,
            movieId: value.movieId,
            originalTitle: value.originalTitle,
            originalLanguage: value.originalLanguage,
            title: value.title,
            backdropPath: value.backdropPath,
            popularity: value.popularity,
            voteCount: value.voteCount,
            video: value.video,
            voteAverage: value.voteAverage,
            isFavorited: value.isFavorited)
        
        return viewModel
    }
}
