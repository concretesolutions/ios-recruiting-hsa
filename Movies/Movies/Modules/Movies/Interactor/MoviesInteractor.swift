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
        worker.fetchMovies { [weak self] (result) in
            self?.worker = MoviesWorker(MoviesCoreDataRepository())
            switch result {
            case .failure(let error):
                self?.presenter?.failure(error)
                break
            case .success(let movies):
                self?.presenter?.fetchMoviesSuccessfull(movies)
                break
            }
        }
    }
    
    //MARK: - Fetch Movies with text (search)
    
    func fetchMovies(with text: String) {
        worker = MoviesWorker(MoviesCoreDataRepository())
        worker.searchMovies(text: text) { [weak self] (result) in
            switch result {
            case .failure(let error):
                self?.presenter?.failure(error)
                break
            case .success(let movies):
                self?.presenter?.fetchMoviesSuccessfull(movies)
                break
            }
        }
    }
    
    //MARK: - Star Movie
    
    func starMovie(_ id: Int32) {
        worker = MoviesWorker(MoviesCoreDataRepository())
        worker.starMovie(id: id) { [weak self] (result) in
            switch result {
            case .success(let resolve):
                print(resolve)
                self?.presenter?.starMovieSuccessfull()
                break
            case .failure(let error):
                self?.presenter?.failure(error)
                break
            }
        }
    }
}
