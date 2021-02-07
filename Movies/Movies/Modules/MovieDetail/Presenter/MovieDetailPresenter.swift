//
//  MovieDetailPresenter.swift
//  Movies
//
//  Created by Alfredo Luco on 05-02-21.
//

import Foundation

class MovieDetailPresenter: ViewToPresenterMovieDetailProtocol {
    //MARK: - Memory debug
    
    deinit {
        print("movie detail presenter dealloc")
    }
    
    //MARK: - Variables
    
    weak var view: PresenterToViewMovieDetailProtocol?
    var interactor: PresenterToInteractorMovieDetailProtocol?
    var router: PresenterToRouterMovieDetailProtocol?
    var movieID: Int32?
    
    //MARK: - Fetch Movie
    
    func fetchMovie() {
        guard let id = movieID else { return }
        interactor?.fetchMovie(id)
    }
    
    //MARK: - Fetch Categories
    
    func fetchCategories() {
        interactor?.fetchCategories()
    }
    
    //MARK: - Star Movie
    
    func starMovie() {
        guard let id = movieID else { return }
        interactor?.starMovie(id)
    }
}


//MARK: - Presentation Logic

extension MovieDetailPresenter: InteractorToPresenterMovieDetailProtocol {
    func fetchMovieSuccessfull(_ movie: Movie) {
        view?.fetchMovieSuccessfull(movie)
    }
    
    func fetchCategoriesSuccessfull(_ categories: [Category]) {
        view?.fetchCategoriesSuccessfull(categories)
    }
    
    func failure(_ error: Error) {
        view?.failure(error)
    }
    
    func starMovieSuccessfull() {
        view?.starMovieSuccessfull()
    }
    
}
