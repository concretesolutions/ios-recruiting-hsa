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
    func removeFilter()
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
    
    var dataFilter : [String:String]? = [:]
    
    init(router : FavoritesRouterProtocol){
        self.interactor = MovieFavoriteInteractor() 
        interactor?.presenter = self
        self.router = router
    }
    
    func attachView(view : FavoritesMovieViewProtocol ){
        self.movieFavoriteView = view
    }
    
    func deAttach(){
        self.movieFavoriteView = nil
    }
    
}

extension MovieFavoritePresenter : MovieFavoritePresenterProtocol{
    func removeFilter() {
        self.dataFilter = [:]
        self.movieFavoriteView?.hideFilterAlert()
        self.fetchFavoriteMovies()
    }
    
    func showFilterView() {
        router.showFavoriteFilter(delegateFilter: self)
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
        if dataFilter!.count == 0{
            movieFavoriteView?.showMovies(movies: viewModels)
        }else{
            let filteredList = viewModels.filter{
                $0.year == dataFilter!["Date"]
            }
            movieFavoriteView?.showFilterAlert()
            movieFavoriteView?.showMovies(movies: filteredList)
        }
    }
    func fetchProductsFailure(message: String){
        
    }
    
    func onDeleteMovieSuccess(){
        fetchFavoriteMovies()
    }
}

extension MovieFavoritePresenter: FilterMovieViewDelegate {
    func filterSelected(filter: [String : String]) {
        self.dataFilter = filter
    }
    
}

