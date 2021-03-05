//
//  FavoritePresenter.swift
//  Movies
//
//  Created by Daniel Nunez on 04-03-21.
//

import Foundation

class FavoritePresenter {

    weak var favoriteController: FavoriteProtocol!
    let favoriteMng: FavoriteManager!

    init(favoriteController: FavoriteProtocol) {
        self.favoriteController = favoriteController
        self.favoriteMng = FavoriteManager()
    }

    func load() {
        guard let movies = favoriteMng.getFavorites() else { return }
        favoriteController.load(movies)
    }

    func deleteFavorite(movie: Movie) {
        movie.isFavorite = false
        favoriteMng.delete(by: movie.id)
    }

}
