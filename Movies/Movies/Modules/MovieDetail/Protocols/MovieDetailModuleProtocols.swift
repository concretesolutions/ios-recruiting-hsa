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
}

//MARK: - Display Logic

protocol PresenterToViewMovieDetailProtocol: class {
    
}

//MARK: - Routing Logic

protocol PresenterToRouterMovieDetailProtocol: class {
    
}

//MARK: - Business Logic

protocol PresenterToInteractorMovieDetailProtocol: class {
    var presenter: InteractorToPresenterMovieDetailProtocol? {get set}
}

//MARK: - Presentation Logic

protocol InteractorToPresenterMovieDetailProtocol: class {
    
}
