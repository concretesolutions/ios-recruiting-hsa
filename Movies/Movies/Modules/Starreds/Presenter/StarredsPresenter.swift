//
//  StarredsPresenter.swift
//  Movies
//
//  Created by Alfredo Luco on 07-02-21.
//

import Foundation

class StarredsPresenter: ViewToPresenterStarredsProtocol {
    //MARK: - Memory debug
    
    deinit {
        print("starreds presenter dealloc")
    }
    
    //MARK: - Variables
    
    weak var view: PresenterToViewStarredsProtocol?
    var interactor: PresenterToInteractorStarredsProtocol?
    var router: PresenterToRouterStarredsProtocol?
    
    //MARK: - Fetch Starreds Movies
    
    func fetchStarredsMovies() {
        interactor?.fetchStarredsMovies()
    }
}

//MARK: - Presentation Logic

extension StarredsPresenter: InteractorToPresenterStarredsProtocol {
    func fetchStarredsMoviesSuccessfull(_ movies: [Movie]) {
        view?.fetchStarredsMoviesSuccessfull(movies)
    }
    
    func failure(_ error: Error) {
        view?.failure(error)
    }
}
