//
//  MovieRepositoryImpl.swift
//  ios-recruiting-hsa
//
//  Created on 07-08-19.
//

class MovieRepositoryImpl: MovieRepository {
    private let datasource: MovieDataSource
    private let movieResponseModelToEntityMapper: Mapper<MovieResponseModel, MovieResponseEntity>
    private let errorModelToEntityMapper: Mapper<ErrorModel, ErrorEntity>
    
    init(datasource: MovieDataSource,
         movieResponseModelToEntityMapper: Mapper<MovieResponseModel, MovieResponseEntity>,
         errorModelToEntityMapper: Mapper<ErrorModel, ErrorEntity>
    ) {
        self.datasource = datasource
        self.movieResponseModelToEntityMapper = movieResponseModelToEntityMapper
        self.errorModelToEntityMapper = errorModelToEntityMapper
    }
    
    func fetchPopular(page: Int, completionHandler: @escaping (MovieResponseModel?, ErrorModel?) -> Void) {
        datasource.fetchPopular(page: page) { (response, error) in
            if let response = response {
                completionHandler(self.movieResponseModelToEntityMapper.reverseMap(value: response), nil)
            } else if let error = error {
                completionHandler(nil, self.errorModelToEntityMapper.reverseMap(value: error))
            } else {
                completionHandler(nil, ErrorModel(message: "Ups! Server error!"))
            }
        }
    }
}
