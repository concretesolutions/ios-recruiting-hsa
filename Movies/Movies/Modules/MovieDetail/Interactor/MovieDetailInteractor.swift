//
//  MovieDetailInteractor.swift
//  Movies
//
//  Created by Alfredo Luco on 05-02-21.
//

import Foundation

class MovieDetailInteractor: PresenterToInteractorMovieDetailProtocol {
    //MARK: - Memory debug
    
    deinit {
        print("movie detail interactor dealloc")
    }
    
    //MARK: - Variables
    
    weak var presenter: InteractorToPresenterMovieDetailProtocol?
}
