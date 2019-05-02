//
//  MovieDetailsViewMoelToModelMapper.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/28/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import Foundation

class MovieDetailsViewMoelToModelMapper: Mapper<MovieDetailsViewModel, MovieDetails>{
    override func reverseMap(value: MovieDetails) -> MovieDetailsViewModel {
        let viewModel = MovieDetailsViewModel(
            genres: value.genres,
            homepage: value.homepage,
            movieId: value.movieId,
            imdbId: value.imdbId,
            originalLanguage: value.originalLanguage,
            originalTitle: value.originalTitle,
            overview: value.overview,
            popularity: value.popularity,
            posterPath: value.posterPath ?? " ",
            releaseDate: value.releaseDate.components(separatedBy: "-").first ?? " ",
            runtime: value.runtime,
            status: value.status,
            tagline: value.tagline,
            title: value.title,
            voteAverage: value.voteAverage,
            voteCount: value.voteCount,
            isFavorited: false
        )
        
        return viewModel
    }
}
