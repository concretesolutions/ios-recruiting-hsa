//
//  MovieResponseModelToEntity.swift
//  ios-recruiting-hsa
//
//  Created on 07-08-19.
//

class MovieResponseModelToEntity: Mapper<MovieResponseModel, MovieResponseEntity> {
    private let movieModelToEntityMapper: Mapper<MovieModel, MovieEntity>
    
    init(movieModelToEntityMapper: Mapper<MovieModel, MovieEntity>) {
        self.movieModelToEntityMapper = movieModelToEntityMapper
    }
    
    override func reverseMap(value: MovieResponseEntity) -> MovieResponseModel {
        return MovieResponseModel(page: value.page,
                                  totalResults: value.totalResults,
                                  totalPages: value.totalPages,
                                  results: movieModelToEntityMapper.reverseMap(values: value.results)
        )
    }
}
