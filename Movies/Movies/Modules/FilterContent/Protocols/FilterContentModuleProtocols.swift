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
}

//MARK: - Display Logic

protocol PresenterToViewFilterContentProtocol: class {
    
}

//MARK: - Routing Logic

protocol PresenterToRouterFilterContentProtocol: class {
    
}

//MARK: - Business Logic

protocol PresenterToInteractorFilterContentProtocol: class {
    var presenter: InteractorToPresenterFilterContentProtocol? {get set}
}

//MARK: - Presentation Logic

protocol InteractorToPresenterFilterContentProtocol: class {
    
}
