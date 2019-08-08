//
//  MovieRestApi.swift
//  ios-recruiting-hsa
//
//  Created on 07-08-19.
//

protocol MovieRestApi {
    func fetchMovies(page: Int, endpoint: Endpoints.Movies, completionHandler: @escaping (MovieResponseEntity?, ErrorEntity?) -> Void)
    
    func fetchMovieDetail(id: Int, endpoint: Endpoints.Movies, completionHandler: @escaping (MovieDetailEntity?, ErrorEntity?) -> Void)
}
