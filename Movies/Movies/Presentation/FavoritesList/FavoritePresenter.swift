//
//  FavoritePresenter.swift
//  Movies
//
//  Created by Daniel Nunez on 04-03-21.
//

import Foundation

class FavoritePresenter {

    weak var favoriteController: FavoriteProtocol!
    weak var delegate: MovieListRefresh?

    let favoriteMng: CacheManager!

    init(favoriteController: FavoriteProtocol) {
        self.favoriteController = favoriteController
        self.favoriteMng = CacheManager()
    }

    func load() {
        guard let movies = favoriteMng.getFavorites() else { return }
        favoriteController.load(movies)
    }

    func deleteFavorite(movie: Movie) {
        movie.isFavorite = false
        favoriteMng.delete(by: movie.id)
    }

    func searchBy(with txt: String) -> [Movie]? {
        guard let movies = favoriteMng.getFavorites() else { return nil }

        let textoABuscar = txt.folding(options: .diacriticInsensitive, locale: .current)
            .lowercased()
        let filtrado = movies
            .filter {
                ($0.title?.folding(options: .diacriticInsensitive, locale: .current).lowercased()
                    .localizedCaseInsensitiveContains(textoABuscar))!
            }

        return filtrado
    }

}
