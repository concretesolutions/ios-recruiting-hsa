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
    fileprivate var worker: MovieDetailWorker = MovieDetailWorker(repo: CategoriesAPIRepository(), repo: MoviesCoreDataRepository())
    
    //MARK: - Fetch Categories
    
    func fetchCategories() {
        worker.fetchCategories { [weak self] (result) in
            switch result {
            case .failure(let error):
                self?.presenter?.failure(error)
                break
            case .success(let categories):
                self?.presenter?.fetchCategoriesSuccessfull(categories)
                break
            }
        }
    }
    
    //MARK: - Fetch Movie
    
    func fetchMovie(_ id: Int32) {
        worker.fetchMovie(by: id) { [weak self] (result) in
            switch result {
            case .failure(let error):
                self?.presenter?.failure(error)
                break
            case .success(let movie):
                self?.presenter?.fetchMovieSuccessfull(movie)
                break
            }
        }
    }
    
    //MARK: - Star Movie
    
    func starMovie(_ id: Int32) {
        worker.starMovie(by: id) { [weak self] (result) in
            switch result {
            case .failure(let error):
                self?.presenter?.failure(error)
                break
            case .success(let resolve):
                print(resolve)
                self?.presenter?.starMovieSuccessfull()
                break
            }
        }
    }
}
