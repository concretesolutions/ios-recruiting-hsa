//
//  MovieDetailModuleProtocols.swift
//  Movies
//
//  Created by Alfredo Luco on 05-02-21.
//

import Foundation

//MARK: - Presenter Logic

protocol ViewToPresenterMovieDetailProtocol: class {
    var view: PresenterToViewMovieDetailProtocol? {get set}
    var interactor: PresenterToInteractorMovieDetailProtocol? {get set}
    var router: PresenterToRouterMovieDetailProtocol? {get set}
    var movieID: Int32? {get set}
    
    func fetchMovie()
    func fetchCategories()
    func starMovie()
}

//MARK: - Display Logic

protocol PresenterToViewMovieDetailProtocol: class {
    func starMovieSuccessfull()
    func fetchMovieSuccessfull(_ movie: Movie)
    func fetchCategoriesSuccessfull(_ categories: [Category])
    func failure(_ error: Error)
}

//MARK: - Routing Logic

protocol PresenterToRouterMovieDetailProtocol: class {
    static func createModule(_ id: Int32) -> MovieDetailViewController
}

//MARK: - Business Logic

protocol PresenterToInteractorMovieDetailProtocol: class {
    var presenter: InteractorToPresenterMovieDetailProtocol? {get set}
    func fetchMovie(_ id: Int32)
    func fetchCategories()
    func starMovie(_ id: Int32)
}

//MARK: - Presentation Logic

protocol InteractorToPresenterMovieDetailProtocol: class {
    func fetchMovieSuccessfull(_ movie: Movie)
    func fetchCategoriesSuccessfull(_ categories: [Category])
    func failure(_ error: Error)
    func starMovieSuccessfull()
}
