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
    func unFavoriteMovie(movie: MovieViewModel)
    func showFilterView()
}

protocol MovieFavoriteOutputPresenterProtocol {
    func onFetchFavoriteMovieSuccess(_ movies: [Movie]?, shouldAppend: Bool)
    func fetchProductsFailure(message: String)
    func onDeleteMovieSuccess()
}

class MovieFavoritePresenter {
    
    weak private var movieFavoriteView : FavoritesMovieViewProtocol?
    var interactor : MovieFavoriteInteractor?
    var router : FavoritesRouterProtocol!
    
    func attachView(view : FavoritesMovieViewProtocol ){
        self.movieFavoriteView = view
    }
    
    func deAttach(){
        self.movieFavoriteView = nil
    }
    
}

extension MovieFavoritePresenter : MovieFavoritePresenterProtocol{
    func showFilterView() {
        router.showFavoriteFilter()
    }
    
    func unFavoriteMovie(movie: MovieViewModel) {
        interactor?.unFavoriteMovie(movieDelete: movie)
    }
    
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
    
    func onDeleteMovieSuccess(){
        fetchFavoriteMovies()
    }
}
