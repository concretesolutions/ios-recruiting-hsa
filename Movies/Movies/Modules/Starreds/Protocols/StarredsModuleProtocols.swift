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
}

//MARK: - Display Logic

protocol PresenterToViewStarredsProtocol: class {
    
}

//MARK: - Routing Logic

protocol PresenterToRouterStarredsProtocol: class {
    
}

//MARK: - Business Logic

protocol PresenterToInteractorStarredsProtocol: class {
    var presenter: InteractorToPresenterStarredsProtocol? {get set}
}

//MARK: - Presentation Logic

protocol InteractorToPresenterStarredsProtocol: class {
    
}
