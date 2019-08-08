//
//  MovieResponseModelToEntity.swift
//  ios-recruiting-hsa
//
//  Created on 07-08-19.
//

class MovieResponseModelToEntity: Mapper<MovieResponseModel, MovieResponseEntity> {
    private let movieModelToEntity: Mapper<MovieModel, MovieEntity>
    
    init(movieModelToEntity: Mapper<MovieModel, MovieEntity>) {
        self.movieModelToEntity = movieModelToEntity
    }
    
    override func reverseMap(value: MovieResponseEntity) -> MovieResponseModel {
        return MovieResponseModel(page: value.page,
                                  totalResults: value.totalResults,
                                  totalPages: value.totalPages,
                                  results: movieModelToEntity.reverseMap(values: value.results)
        )
    }
}
