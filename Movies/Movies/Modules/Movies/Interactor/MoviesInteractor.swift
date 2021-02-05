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
    private var worker: MoviesWorker = MoviesWorker(MoviesAPIRepository())
    
    //MARK: - Fetch Movies
    
    func fetchMovies() {
        worker.fetchMovies { (result) in
            self.worker = MoviesWorker(MoviesCoreDataRepository())
            switch result {
            case .failure(let error):
                self.presenter?.failure(error)
                break
            case .success(let movies):
                self.presenter?.fetchMoviesSuccessfull(movies)
                break
            }
        }
    }
    
    func fetchMovies(with text: String) {
        worker = MoviesWorker(MoviesCoreDataRepository())
        worker.searchMovies(text: text) { (result) in
            switch result {
            case .failure(let error):
                self.presenter?.failure(error)
                break
            case .success(let movies):
                self.presenter?.fetchMoviesSuccessfull(movies)
                break
            }
        }
    }
}
