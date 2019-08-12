//
//  MovieDataSourceImpl.swift
//  ios-recruiting-hsa
//
//  Created on 07-08-19.
//

class MovieDataSourceImpl: MovieDataSource {
    private let restApi: MovieRestApi
    
    init(restApi: MovieRestApi) {
        self.restApi = restApi
    }
    
    func fetchMovies(page: Int, completionHandler: @escaping (MovieResponseEntity?, ErrorEntity?) -> Void) {
        restApi.fetchMovies(page: page, endpoint: Endpoints.Movies.popular) { (movieList, error) in
            completionHandler(movieList, error)
        }
    }
    
    func fetchMovieDetail(id: Int, completionHandler: @escaping (MovieDetailEntity?, ErrorEntity?) -> Void) {
        restApi.fetchMovieDetail(id: id, endpoint: Endpoints.Movies.movieDetail) { (movieDettail, error) in
            completionHandler(movieDettail, error)
        }
    }
}
