//
//  MovieFavoritePresenter.swift
//  MovieApp
//
//  Created by Sebastian Diaz on 4/6/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import Foundation

protocol MovieFavoritePresenterProtocol {
    func fetchFavoriteMovies()
}

protocol MovieFavoriteOutputPresenterProtocol {
    func onFetchFavoriteMovieSuccess(_ movies: [Movie]?, shouldAppend: Bool)
    func fetchProductsFailure(message: String)
}

class MovieFavoritePresenter {
    
    weak private var movieFavoriteView : FavoritesMovieViewProtocol?
    var interactor : MovieFavoriteInteractor?
    
    
    func attachView(view : FavoritesMovieViewProtocol ){
        self.movieFavoriteView = view
    }
    
    func deAttach(){
        self.movieFavoriteView = nil
    }
    
}

extension MovieFavoritePresenter : MovieFavoritePresenterProtocol{
    func fetchFavoriteMovies() {
        interactor?.fetchMovies()
    }

}

extension MovieFavoritePresenter : MovieFavoriteOutputPresenterProtocol {
    func onFetchFavoriteMovieSuccess(_ movies: [Movie]?, shouldAppend: Bool){
        let viewModels = createMovieViewModels(from: movies!)
        movieFavoriteView?.showMovies(movies: viewModels)
    }
    func fetchProductsFailure(message: String){
        
    }
}
