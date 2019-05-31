//
//  DetailMovieViewModel.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/31/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation

protocol DetailMovieViewModel {

    var onFavouriteChange: (Bool) -> Void { get set }

    var title: String { get }
    var isFavorite: Bool { get }
    var titleMovie: String { get }
    var yearMovie: String { get }
    var genres: String { get }
    var posterURL: URL? { get }
    var descriptionMovie: String { get }
    func toggleFavorite()
}

class DetailMovieViewModelImpl {

    var onFavouriteChange: (Bool) -> Void = { _ in }

    private let movie: PopularMovie
    private let favoritesManager: FavoritesManager
    private let genreManager: GenreManager

    init(movie: PopularMovie, favoritesManager: FavoritesManager, genreManager: GenreManager) {
        self.movie = movie
        self.favoritesManager = favoritesManager
        self.genreManager = genreManager
    }
}

extension DetailMovieViewModelImpl: DetailMovieViewModel {
    var title: String { return "Detail" }
    var isFavorite: Bool { return favoritesManager.isFavorite(movie: movie) }
    var titleMovie: String { return movie.title ?? "" }
    var yearMovie: String { return movie.releaseDate ?? "" }
    var posterURL: URL? { return movie.posterURL }
    var descriptionMovie: String { return movie.overview ?? "" }

    var genres: String {
        let genres = movie.genreIds ?? []
        let mappedGenres = genres.compactMap { genreManager.genreFor(id: $0) }
        let actualGenres = mappedGenres.joined(separator: ", ")
        return actualGenres
    }

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
