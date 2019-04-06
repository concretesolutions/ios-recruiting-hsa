//
//  MovieDetailPresenter.swift
//  MovieApp
//
//  Created by Sebastian Diaz on 4/5/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import Foundation

protocol MovieDetailPresenterProtocol{
    func showDetailMovie(movie : MovieViewModel)
    func addToFavoriteAction(movie : MovieViewModel)
    func backAction()
}

class MovieDetailPresenter {
    
    weak private var movieDetailView : MovieDetailViewProtocol?
    
    
    func attachView(view : MovieDetailViewProtocol){
        self.movieDetailView = view
    }
    
    func deAttach(){
        self.movieDetailView = nil
    }
    
}
extension MovieDetailPresenter : MovieDetailPresenterProtocol {
    func showDetailMovie(movie: MovieViewModel) {
        
    }
    
    func addToFavoriteAction(movie: MovieViewModel) {
        
    }
    
    func backAction() {
        
    }    
}
