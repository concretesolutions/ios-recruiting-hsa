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
}

//MARK: - Display Logic

protocol PresenterToViewMoviesProtocol: class {
    
}

//MARK: - Routing Logic

protocol PresenterToRouterMoviesProtocol: class {
    
}

//MARK: - Business Logic

protocol PresenterToInteractorMoviesProtocol: class {
    var presenter: InteractorToPresenterMoviesProtocol? {get set}
}

//MARK: - Presentation Logic

protocol InteractorToPresenterMoviesProtocol: class {
    
}
