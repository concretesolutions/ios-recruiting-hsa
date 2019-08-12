//
//  MovieDetailViewToFavoriteMovieModel.swift
//  ios-recruiting-hsa
//
//  Created by Freddy Miguel Vega Zárate on 8/12/19.
//  Copyright © 2019 Freddy Miguel Vega Zárate. All rights reserved.
//

class MovieDetailViewToFavoriteMovieModel: Mapper<MovieDetailView, FavoriteMovieModel> {
    override func map(value: MovieDetailView) -> FavoriteMovieModel {
        return FavoriteMovieModel(id: value.id,
                                  title: value.title,
                                  overview: value.overview,
                                  posterPath: value.posterPath,
                                  genres: value.genres,
                                  year: value.releaseDate
        )
    }
}
