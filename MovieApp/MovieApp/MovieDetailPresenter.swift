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
}

class MovieDetailPresenter {
    
    weak private var movieDetailView : MovieDetailViewProtocol?
    var interactor : MovieDetailInteractorProtocol?
   
    init(interactor : MovieDetailInteractorProtocol){
        self.interactor = interactor
    }
    
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
        var genreid : [Int] = []
        
        for genre in movie.genres {
            genreid.append(genre.id)
        }
        interactor?.saveMovie(movie: Movie(id: movie.id, title: movie.title, releaseDate: movie.year, genres: genreid, overview: movie.overview, imagePath: movie.imagePath))
    } 
}
