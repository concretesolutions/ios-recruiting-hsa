//
//  MoviesModuleProtocols.swift
//  Movies
//
//  Created by Alfredo Luco on 05-02-21.
//

import Foundation

//MARK: - Presenter Logic

protocol ViewToPresenterMoviesProtocol: class {
    var view: PresenterToViewMoviesProtocol? {get set}
    var interactor: PresenterToInteractorMoviesProtocol? {get set}
    var router: PresenterToRouterMoviesProtocol? {get set}
    
    func fetchMovies()
    func fetchMovies(with text: String)
    func starMovie(_ id: Int32)
}

//MARK: - Display Logic

protocol PresenterToViewMoviesProtocol: class {
    func starMovieSuccessfull()
    func fetchMoviesSuccessfull(_ movies: [Movie])
    func failure(_ error: Error)
}

//MARK: - Routing Logic

protocol PresenterToRouterMoviesProtocol: class {
    static func createModule() -> MoviesViewController
}

//MARK: - Business Logic

protocol PresenterToInteractorMoviesProtocol: class {
    var presenter: InteractorToPresenterMoviesProtocol? {get set}
    
    func fetchMovies()
    func fetchMovies(with text: String)
    func starMovie(_ id: Int32)
}

//MARK: - Presentation Logic

protocol InteractorToPresenterMoviesProtocol: class {
    func starMovieSuccessfull()
    func fetchMoviesSuccessfull(_ movies: [Movie])
    func failure(_ error: Error)
}
