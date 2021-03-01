//
//  FavoritesListPresenter.swift
//  MoviesApp
//
//  Created by Hector Morales on 3/1/21.
//

import Foundation

protocol FavoritesListPresenterProtocol: class {
    func loadMoviesFavorites(items: [Movie])
    func gotDeleteMovieSuccessfully()
}

class FavoritesListPresenter {

    weak var dataSourcePresenterProtocol: FavoritesListPresenterProtocol?
    var favoritesListHandler: FavoritesListHandler!

    init(dataSource: FavoritesListPresenterProtocol) {
        dataSourcePresenterProtocol = dataSource
        favoritesListHandler = FavoritesListHandler(dataSource: self)
    }

    func loadFavorites(){
        favoritesListHandler.loadFavorites()
    }

    func deleteMovieFromFavorites(movie: Movie){
        favoritesListHandler.deleteFavoriteMovie(movie: movie)
    }
    
}

extension FavoritesListPresenter: FavoritesListHandlerProtocol {
    func loadFavorites(movies: [Movie]) {
        dataSourcePresenterProtocol?.loadMoviesFavorites(items: movies)
    }

    func gotDeleteFavoriteSuccessfull() {
        dataSourcePresenterProtocol?.gotDeleteMovieSuccessfully()
    }
}
