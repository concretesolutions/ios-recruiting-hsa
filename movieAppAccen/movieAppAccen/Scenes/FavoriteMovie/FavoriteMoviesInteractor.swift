//
//  FavoriteMoviesInteractor.swift
//  movieAppAccen
//
//  Created by Orlando Velasco on 22-10-23.
//

import Foundation

class FavoriteMoviesInteractor {
    func fetchFavoriteMovies() -> [FavoriteMovie] {
        return FavoriteMovieManager().fetchAllFavorites()
    }
}
