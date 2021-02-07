//
//  FilterContentModuleProtocols.swift
//  Movies
//
//  Created by Alfredo Luco on 07-02-21.
//

import Foundation

//MARK: - Presenter Logic

protocol ViewToPresenterFilterContentProtocol: class {
    var view: PresenterToViewFilterContentProtocol? {get set}
    var interactor: PresenterToInteractorFilterContentProtocol? {get set}
    var router: PresenterToRouterFilterContentProtocol? {get set}
    var filterType: FilterContent {get set}
    
    func fetchContent()
}

//MARK: - Display Logic

protocol PresenterToViewFilterContentProtocol: class {
    func fetchContentSuccessfull(_ content: [String])
    func failure(_ error: Error)
}

//MARK: - Routing Logic

protocol PresenterToRouterFilterContentProtocol: class {
    static func createModule(_ contentType: FilterContent) -> FilterContentViewController
}

//MARK: - Business Logic

protocol PresenterToInteractorFilterContentProtocol: class {
    var presenter: InteractorToPresenterFilterContentProtocol? {get set}
    func fetchContent(_ type: FilterContent)
}

//MARK: - Presentation Logic

protocol InteractorToPresenterFilterContentProtocol: class {
    func fetchContentSuccessfull(_ content: [String])
    func failure(_ error: Error)
}
