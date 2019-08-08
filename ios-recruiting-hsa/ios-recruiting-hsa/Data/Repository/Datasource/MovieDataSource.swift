//
//  MovieDataSource.swift
//  ios-recruiting-hsa
//
//  Created on 07-08-19.
//

protocol MovieDataSource {
    func fetchMovies(page: Int, completionHandler: @escaping (MovieResponseEntity?, ErrorEntity?) -> Void)
    
    func fetchMovieDetail(id: Int, completionHandler: @escaping (MovieDetailEntity?, ErrorEntity?) -> Void)
}
