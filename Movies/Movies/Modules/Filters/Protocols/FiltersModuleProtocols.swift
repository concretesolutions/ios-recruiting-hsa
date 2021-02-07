//
//  FiltersModuleProtocols.swift
//  Movies
//
//  Created by Alfredo Luco on 07-02-21.
//

import Foundation

//MARK: - Presenter Logic

protocol ViewToPresenterFiltersProtocol: class {
    var view: PresenterToViewFiltersProtocol? {get set}
    var interactor: PresenterToInteractorFiltersProtocol? {get set}
    var router: PresenterToRouterFiltersProtocol? {get set}
}

//MARK: - Display Logic

protocol PresenterToViewFiltersProtocol: class {
    
}

//MARK: - Routing Logic

protocol PresenterToRouterFiltersProtocol: class {
    
}

//MARK: - Business Logic

protocol PresenterToInteractorFiltersProtocol: class {
    var presenter: InteractorToPresenterFiltersProtocol? {get set}
}

//MARK: - Presentation Logic

protocol InteractorToPresenterFiltersProtocol: class {
    
}
