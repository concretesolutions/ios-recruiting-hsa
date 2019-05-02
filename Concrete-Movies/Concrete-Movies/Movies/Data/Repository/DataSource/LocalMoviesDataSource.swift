//
//  LocalMoviesDataSource.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/30/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import Foundation

protocol LocalMoviesDataSource {
    func favoritedMoviesEntity(completionHandler: @escaping ([FavoritedMovieEntity]?, Error?)->Void)
    func saveFavorited(movie: FavoritedMovieEntity)
    func deleteFavoriteMovie(with id: Int)
}
