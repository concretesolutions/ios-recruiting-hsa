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
    
    func fetchFilters()
}

//MARK: - Display Logic

protocol PresenterToViewFiltersProtocol: class {
    func fetchFiltersSuccessfull(_ filters: [Filter<String>])
    func failure(_ error: Error)
}

//MARK: - Routing Logic

protocol PresenterToRouterFiltersProtocol: class {
    static func createModule() -> FiltersViewController
}

//MARK: - Business Logic

protocol PresenterToInteractorFiltersProtocol: class {
    var presenter: InteractorToPresenterFiltersProtocol? {get set}
    func fetchFilters()
}

//MARK: - Presentation Logic

protocol InteractorToPresenterFiltersProtocol: class {
    func fetchFiltersSuccessfull(_ filters: [Filter<String>])
    func failure(_ error: Error)
}
