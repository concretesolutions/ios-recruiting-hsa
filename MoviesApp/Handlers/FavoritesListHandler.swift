//
//  FavoritesListHandler.swift
//  MoviesApp
//
//  Created by Hector Morales on 3/1/21.
//

import Foundation

protocol FavoritesListHandlerProtocol: class {
    func loadFavorites(movies: [Movie])
    func gotDeleteFavoriteSuccessfull()
}

class FavoritesListHandler {

    weak var dataSourceProtocol: FavoritesListHandlerProtocol?
    var favoritesAPI = FavoritesAPI()

    init(dataSource: FavoritesListHandlerProtocol) {
        self.dataSourceProtocol = dataSource
    }

    func loadFavorites() {
        let favorites = favoritesAPI.loadFavorites()
        dataSourceProtocol?.loadFavorites(movies: favorites ?? [])
    }

    func deleteFavoriteMovie(movie: Movie){
        favoritesAPI.deleteFavoriteMovie(movieId: movie.id)
        dataSourceProtocol?.gotDeleteFavoriteSuccessfull()
    }



}
