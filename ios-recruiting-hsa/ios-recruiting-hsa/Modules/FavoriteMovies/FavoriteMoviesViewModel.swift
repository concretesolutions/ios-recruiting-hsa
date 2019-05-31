//
//  FavoriteMoviesViewModel.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/31/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation

protocol FavoriteMoviesViewModel {
    var title: String { get }
    var count: Int { get }
    func cellViewModel(forIndex index: IndexPath) -> FavoriteMovieCellViewModel
}

// Implementation

class FavoriteMoviesViewModelImpl {

    private let favoritesManager: FavoritesManager

    init(favoritesManager: FavoritesManager) {
        self.favoritesManager = favoritesManager
    }

}

extension FavoriteMoviesViewModelImpl: FavoriteMoviesViewModel {
    var title: String { return "Favorites" }
    var count: Int { return favoritesManager.getFavouritesMovies.count }

    func cellViewModel(forIndex index: IndexPath) -> FavoriteMovieCellViewModel {
        let movie = favoritesManager.getFavouritesMovies[index.row]
        let cellViewModel = FavoriteMovieCellViewModelImpl(movie: movie)
        return cellViewModel
    }
}
