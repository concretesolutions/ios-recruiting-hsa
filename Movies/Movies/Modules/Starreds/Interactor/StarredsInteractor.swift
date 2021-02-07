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
}
