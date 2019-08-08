//
//  MovieRepositoryImpl.swift
//  ios-recruiting-hsa
//
//  Created on 07-08-19.
//

class MovieRepositoryImpl: MovieRepository {
    private let datasource: MovieDataSource
    private let movieResponseModelToEntity: Mapper<MovieResponseModel, MovieResponseEntity>
    private let movieDetailModelToEntity: Mapper<MovieDetailModel, MovieDetailEntity>
    private let errorModelToEntity: Mapper<ErrorModel, ErrorEntity>
    
    init(datasource: MovieDataSource,
         movieResponseModelToEntity: Mapper<MovieResponseModel, MovieResponseEntity>,
         movieDetailModelToEntity: Mapper<MovieDetailModel, MovieDetailEntity>,
         errorModelToEntity: Mapper<ErrorModel, ErrorEntity>
    ) {
        self.datasource = datasource
        self.movieResponseModelToEntity = movieResponseModelToEntity
        self.movieDetailModelToEntity = movieDetailModelToEntity
        self.errorModelToEntity = errorModelToEntity
    }
    
    func fetchMovies(page: Int, completionHandler: @escaping (MovieResponseModel?, ErrorModel?) -> Void) {
        datasource.fetchMovies(page: page) { (movieList, error) in
            if let movieList = movieList {
                completionHandler(self.movieResponseModelToEntity.reverseMap(value: movieList), nil)
            } else if let error = error {
                completionHandler(nil, self.errorModelToEntity.reverseMap(value: error))
            }
        }
    }
    
    func fetchMovieDetail(id: Int, completionHandler: @escaping (MovieDetailModel?, ErrorModel?) -> Void) {
        datasource.fetchMovieDetail(id: id) { (movieDetail, error) in
            if let movieDetail = movieDetail {
                completionHandler(self.movieDetailModelToEntity.reverseMap(value: movieDetail), nil)
            } else if let error = error {
                completionHandler(nil, self.errorModelToEntity.reverseMap(value: error))
            }
        }
    }
}
