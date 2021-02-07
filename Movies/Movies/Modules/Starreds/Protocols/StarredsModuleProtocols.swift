//
//  StarredsModuleProtocols.swift
//  Movies
//
//  Created by Alfredo Luco on 07-02-21.
//

import Foundation

//MARK: - Presenter Logic

protocol ViewToPresenterStarredsProtocol: class {
    var view: PresenterToViewStarredsProtocol? {get set}
    var interactor: PresenterToInteractorStarredsProtocol? {get set}
    var router: PresenterToRouterStarredsProtocol? {get set}
    
    func fetchStarredsMovies()
}

//MARK: - Display Logic

protocol PresenterToViewStarredsProtocol: class {
    func fetchStarredsMoviesSuccessfull(_ movies: [Movie])
    func failure(_ error: Error)
}

//MARK: - Routing Logic

protocol PresenterToRouterStarredsProtocol: class {
    
}

//MARK: - Business Logic

protocol PresenterToInteractorStarredsProtocol: class {
    var presenter: InteractorToPresenterStarredsProtocol? {get set}
    func fetchStarredsMovies()
}

//MARK: - Presentation Logic

protocol InteractorToPresenterStarredsProtocol: class {
    func fetchStarredsMoviesSuccessfull(_ movies: [Movie])
    func failure(_ error: Error)
}
