//
//  LocalDBMoviesDataSource.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/30/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import Foundation

class LocalDBMoviesDataSource: LocalMoviesDataSource{
    
    private let localMoviesDB: LocalMoviesDB
    
    init(localMoviesDB: LocalMoviesDB) {
        self.localMoviesDB = localMoviesDB
    }
    
    func favoritedMoviesEntity(completionHandler: @escaping ([FavoritedMovieEntity]?, Error?) -> Void) {
        localMoviesDB.favoritedMoviesEntity { (favoritedMovies, error) in
            completionHandler(favoritedMovies, error)
        }
    }
    
    func saveFavorited(movie: FavoritedMovieEntity) {
        localMoviesDB.saveFavorited(movie: movie)
    }
    
    func deleteFavoriteMovie(with id: Int) {
        localMoviesDB.deleteFavoriteMovie(with: id)
    }
}
