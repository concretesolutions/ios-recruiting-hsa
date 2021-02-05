//
//  MoviesPresenter.swift
//  Movies
//
//  Created by Alfredo Luco on 05-02-21.
//

import Foundation

class MoviesPresenter: ViewToPresenterMoviesProtocol {
    
    //MARK: - Memory debug
    
    deinit {
        print("Movies Presenter Dealloc")
    }
    
    //MARK: - Variables
    
    weak var view: PresenterToViewMoviesProtocol?
    var interactor: PresenterToInteractorMoviesProtocol?
    var router: PresenterToRouterMoviesProtocol?
    
    //MARK: - Fetch Movies
    
    func fetchMovies() {
        interactor?.fetchMovies()
    }
}


//MARK: - Presentation Logic

extension MoviesPresenter: InteractorToPresenterMoviesProtocol {
    func fetchMoviesSuccessfull(_ movies: [Movie]) {
        view?.fetchMoviesSuccessfull(movies)
    }
    
    func failure(_ error: Error) {
        view?.failure(error)
    }
}
