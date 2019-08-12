//
//  FavoriteMovieViewToModel.swift
//  ios-recruiting-hsa
//
//  Created on 8/12/19.
//

class FavoriteMovieViewToModel: Mapper<FavoriteMovieView, FavoriteMovieModel> {
    override func reverseMap(value: FavoriteMovieModel) -> FavoriteMovieView {
        return FavoriteMovieView(id: value.id,
                                 title: value.title,
                                 overview: value.overview,
                                 posterPath: value.posterPath,
                                 genres: value.genres,
                                 year: value.year
        )
    }
    
    override func map(value: FavoriteMovieView) -> FavoriteMovieModel {
        return FavoriteMovieModel(id: value.id,
                                  title: value.title,
                                  overview: value.overview,
                                  posterPath: value.posterPath,
                                  genres: value.genres,
                                  year: value.year
        )
    }
}
