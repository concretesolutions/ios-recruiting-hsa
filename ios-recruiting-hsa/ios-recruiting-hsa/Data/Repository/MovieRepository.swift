//
//  MovieRepository.swift
//  ios-recruiting-hsa
//
//  Created on 07-08-19.
//

protocol MovieRepository {
    func fetchMovies(page: Int, completionHandler: @escaping (MovieResponseModel?, ErrorModel?) -> Void)
    
    func fetchMovieDetail(id: Int, completionHandler: @escaping (MovieDetailModel?, ErrorModel?) -> Void)
}
