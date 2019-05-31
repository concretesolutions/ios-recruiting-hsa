//
//  FavoriteMoviesViewModel.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/31/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation

protocol FavoriteMoviesViewModel {
    var removeAtIndex: (IndexPath) -> Void { get set }

    var title: String { get }
    var count: Int { get }
    func remove(at indexPath: IndexPath)
    func select(indexPath: IndexPath)
    func cellViewModel(forIndex index: IndexPath) -> FavoriteMovieCellViewModel
}

// Implementation

class FavoriteMoviesViewModelImpl {

    var removeAtIndex: (IndexPath) -> Void = { _ in }
    var onSelectMovie: (PopularMovie) -> Void = { _ in }

    private let favoritesManager: FavoritesManager

    init(favoritesManager: FavoritesManager) {
        self.favoritesManager = favoritesManager
    }

}

extension FavoriteMoviesViewModelImpl: FavoriteMoviesViewModel {
    var title: String { return "Favorites" }
    var count: Int { return favoritesManager.getFavouritesMovies.count }

    func select(indexPath: IndexPath) {
        let movie = favoritesManager.getFavouritesMovies[indexPath.row]
        onSelectMovie(movie)
    }

    func remove(at indexPath: IndexPath) {
        let movie = favoritesManager.getFavouritesMovies[indexPath.row]
        favoritesManager.remove(movie: movie)
        removeAtIndex(indexPath)
    }

    func cellViewModel(forIndex index: IndexPath) -> FavoriteMovieCellViewModel {
        let movie = favoritesManager.getFavouritesMovies[index.row]
        let cellViewModel = FavoriteMovieCellViewModelImpl(movie: movie)
        return cellViewModel
    }
}
