//
//  MoviesInteractor.swift
//  Movies
//
//  Created by Alfredo Luco on 05-02-21.
//

import Foundation

class MoviesInteractor: PresenterToInteractorMoviesProtocol {
    //MARK: - Memory debug
    
    deinit {
        print("Movies interactor dealloc")
    }
    
    //MARK: - Variables
    
    weak var presenter: InteractorToPresenterMoviesProtocol?
}
