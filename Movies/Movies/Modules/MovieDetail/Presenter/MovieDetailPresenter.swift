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
    
}


//MARK: - Presentation Logic

extension MovieDetailPresenter: InteractorToPresenterMovieDetailProtocol {
    
}
