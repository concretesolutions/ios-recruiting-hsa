//
//  DetailMovieHandler.swift
//  MoviesApp
//
//  Created by Hector Morales on 2/28/21.
//

import Foundation

protocol DetailMovieHandlerProtocol: class {
    func gotMovie(movie: Movie)
    func gotSavedFavoriteSuccessfull()
}

class DetailMovieHandler {

    weak var dataSourceProtocol: DetailMovieHandlerProtocol?
    var favoritesAPI = FavoritesAPI()

    init(dataSource: DetailMovieHandlerProtocol) {
        self.dataSourceProtocol = dataSource
    }

    func loadFullMovie(movie: Movie) -> Movie {
        movie.genresString = GenresHandler.getGenresById(genresId: movie.genreIDS)
        movie.isFavorited = favoritesAPI.existsFavoriteInStorage(movie: movie)
        return movie
    }

    func saveMovieInFavorite(movie: Movie) {
        favoritesAPI.saveSingleFavorite(movie: movie)
        dataSourceProtocol?.gotSavedFavoriteSuccessfull()
    }

}
