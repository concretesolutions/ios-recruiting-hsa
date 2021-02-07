//
//  StarredsInteractor.swift
//  Movies
//
//  Created by Alfredo Luco on 07-02-21.
//

import Foundation

class StarredsInteractor: PresenterToInteractorStarredsProtocol {
    //MARK: - Memory debug
    
    deinit {
        print("starreds interactor dealloc")
    }
    
    //MARK: - Variables
    
    weak var presenter: InteractorToPresenterStarredsProtocol?
    fileprivate var worker: StarredsWorker = StarredsWorker(MoviesCoreDataRepository())
    
    //MARK: - Fetch Starreds Movies
    
    func fetchStarredsMovies() {
        worker.fetchStarredsMovies { [weak self] (result) in
            switch result {
            case .success(let movies):
                self?.presenter?.fetchStarredsMoviesSuccessfull(movies)
                break
            case .failure(let error):
                self?.presenter?.failure(error)
                break
            }
        }
    }
    
    //MARK: - Unstar Movie
    
    func unstarMovie(_ id: Int32) {
        worker.unstarMovie(id) { [weak self] (result) in
            switch result {
            case .failure(let error):
                self?.presenter?.failure(error)
                break
            case .success(let resolve):
                print(resolve)
                self?.presenter?.unstarMovieSuccessfull()
                break
            }
        }
    }
    
    //MARK: - Filter Movies
    
    func filterMovies(_ filters: [Filter<String>]) {
        worker.filterMovies(filters) { [weak self] (result) in
            switch result {
            case .success(let movies):
                self?.presenter?.fetchFilteredMoviesSuccessfull(movies)
                break
            case .failure(let error):
                self?.presenter?.failure(error)
                break
            }
        }
    }
}
