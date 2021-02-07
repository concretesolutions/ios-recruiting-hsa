//
//  StarredsPresenter.swift
//  Movies
//
//  Created by Alfredo Luco on 07-02-21.
//

import Foundation

class StarredsPresenter: ViewToPresenterStarredsProtocol {
    //MARK: - Memory debug
    
    deinit {
        print("starreds presenter dealloc")
    }
    
    //MARK: - Variables
    
    weak var view: PresenterToViewStarredsProtocol?
    var interactor: PresenterToInteractorStarredsProtocol?
    var router: PresenterToRouterStarredsProtocol?
}

//MARK: - Presentation Logic

extension StarredsPresenter: InteractorToPresenterStarredsProtocol {
    
}
