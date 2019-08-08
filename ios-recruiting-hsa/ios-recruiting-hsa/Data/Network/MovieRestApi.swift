//
//  MovieRestApi.swift
//  ios-recruiting-hsa
//
//  Created on 07-08-19.
//

protocol MovieRestApi {
    func genres(endpoint: Endpoints.Movies, completionHandler: @escaping ([GenreEntity]?, ErrorEntity?) -> Void)
    
    func fetchMovies(page: Int, endpoint: Endpoints.Movies, completionHandler: @escaping (MovieResponseEntity?, ErrorEntity?) -> Void)
    
    func fetchMovieDetail(page: Int, endpoint: Endpoints.Movies, completionHandler: @escaping (MovieResponseEntity?, ErrorEntity?) -> Void)
}
