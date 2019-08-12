//
//  MovieLocalData.swift
//  ios-recruiting-hsa
//
//  Created on 8/12/19.
//

protocol MovieLocalData {
    func save(movie: FavoriteMovieEntity, completionHandler: @escaping (ErrorEntity?) -> Void)
    
    func fetch(completionHandler: @escaping ([FavoriteMovieEntity]?, ErrorEntity?) -> Void)
    
    func fetch(movieId: Int, completionHandler: @escaping (FavoriteMovieEntity?, ErrorEntity?) -> Void)
    
    func delete(movie: FavoriteMovieEntity, completionHandler: @escaping (ErrorEntity?) -> Void)
}
