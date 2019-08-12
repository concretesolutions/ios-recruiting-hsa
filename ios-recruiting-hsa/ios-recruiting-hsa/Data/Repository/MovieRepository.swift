//
//  MovieRepository.swift
//  ios-recruiting-hsa
//
//  Created on 07-08-19.
//

protocol MovieRepository {
    func fetchMovies(page: Int, completionHandler: @escaping (MovieResponseModel?, ErrorModel?) -> Void)
    
    func fetchMovieDetail(id: Int, completionHandler: @escaping (MovieDetailModel?, ErrorModel?) -> Void)
    
    func save(movie: FavoriteMovieModel, completionHandler: @escaping (ErrorModel?) -> Void)
    
    func fetch(completionHandler: @escaping ([FavoriteMovieModel]?, ErrorModel?) -> Void)
    
    func fetch(movieId: Int, completionHandler: @escaping (FavoriteMovieModel?, ErrorModel?) -> Void)
    
    func delete(movie: FavoriteMovieModel, completionHandler: @escaping (ErrorModel?) -> Void)
}
