//
//  MovieModelToEntity.swift
//  ios-recruiting-hsa
//
//  Created on 07-08-19.
//

class MovieModelToEntity: Mapper<MovieModel, MovieEntity> {
    override func reverseMap(value: MovieEntity) -> MovieModel {
        return MovieModel(voteCount: value.voteCount,
                          id: value.id,
                          isVideo: value.isVideo,
                          voteAverage: value.voteAverage,
                          title: value.title,
                          popularity: value.popularity,
                          posterPath: value.posterPath,
                          originalLanguage: value.originalLanguage,
                          originalTitle: value.originalTitle,
                          genreIds: value.genreIds,
                          backdropPath: value.backdropPath,
                          isAdult: value.isAdult,
                          overview: value.overview,
                          releaseDate: FormatHelper.date(from: value.releaseDate)
        )
    }
}
