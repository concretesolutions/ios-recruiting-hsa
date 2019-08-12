//
//  FavoritePresenter.swift
//  ios-recruiting-hsa
//
//  Created on 8/12/19.
//

protocol FavoritePresenter {
    func attach(view: FavoriteView)
    func favoriteMovies()
    func deleteFavorite(movie: FavoriteMovieView)
}
