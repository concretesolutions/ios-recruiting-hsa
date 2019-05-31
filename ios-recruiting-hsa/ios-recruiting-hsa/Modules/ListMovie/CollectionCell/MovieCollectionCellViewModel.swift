//
//  MovieCollectionCellViewModel.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/30/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation

protocol MovieCollectionCellViewModel: class {
    var onFavouriteChange: (Bool) -> Void { get set }

    var title: String { get }
    var posterURL: URL? { get }
    var isFavorite: Bool { get }
    func toggleFavorite()
}

// Implementation

class MovieCollectionCellViewModelImpl {

    var onFavouriteChange: (Bool) -> Void = { _ in }

    private let movie: PopularMovie
    private let favoritesManager: FavoritesManager

    init(movie: PopularMovie, favoritesManager: FavoritesManager) {
        self.movie = movie
        self.favoritesManager = favoritesManager
    }
}

extension MovieCollectionCellViewModelImpl: MovieCollectionCellViewModel {
    var title: String { return movie.title ?? "" }
    var isFavorite: Bool { return favoritesManager.isFavorite(movie: movie) }
    var posterURL: URL? { return movie.posterURL }

    func toggleFavorite() {
        let isFavorite = self.isFavorite
        if isFavorite {
            favoritesManager.remove(movie: movie)
        } else {
            favoritesManager.add(movie: movie)
        }
        onFavouriteChange(!isFavorite)
    }
}
