//
//  PartModelToEntity.swift
//  ios-recruiting-hsa
//
//  Created on 08-08-19.
//

class PartModelToEntity: Mapper<PartModel, PartEntity> {
    override func reverseMap(value : PartEntity) -> PartModel {
        return PartModel(isAdult: value.isAdult,
                         backdropPath: value.backdropPath,
                         genreIds: value.genreIds,
                         id: value.id,
                         originalLanguage: value.originalLanguage,
                         originalTitle: value.originalTitle,
                         overview: value.overview,
                         releaseDate: value.releaseDate,
                         posterPath: value.posterPath,
                         popularity: value.popularity,
                         title: value.title,
                         isVideo: value.isVideo,
                         voteAverage: value.voteAverage,
                         voteCount: value.voteCount)
        
    }
}
