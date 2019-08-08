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
    
    func fetchPopular(page: Int, completionHandler: @escaping (MovieResponseEntity?, ErrorEntity?) -> Void) {
        restApi.fetchMovies(page: page, endpoint: Endpoints.Movies.popular) { (response, error) in
            completionHandler(response, error)
        }
    }
}
