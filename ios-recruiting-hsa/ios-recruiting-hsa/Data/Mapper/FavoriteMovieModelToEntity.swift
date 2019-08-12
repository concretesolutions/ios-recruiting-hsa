//
//  FavoriteMovieModelToEntity.swift
//  ios-recruiting-hsa
//
//  Created on 8/12/19.
//

class FavoriteMovieModelToEntity: Mapper<FavoriteMovieModel, FavoriteMovieEntity> {
    override func reverseMap(value: FavoriteMovieEntity) -> FavoriteMovieModel {
        return FavoriteMovieModel(id: value.id,
                                 title: value.title,
                                 overview: value.overview,
                                 posterPath: value.posterPath,
                                 genres: value.genres,
                                 year: value.year
        )
    }
    
    override func map(value: FavoriteMovieModel) -> FavoriteMovieEntity {
        return FavoriteMovieEntity(id: value.id,
                                  title: value.title,
                                  overview: value.overview,
                                  posterPath: value.posterPath,
                                  genres: value.genres,
                                  year: value.year
        )
    }
}
