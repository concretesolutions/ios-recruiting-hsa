//
//  StarredsInteractor.swift
//  Movies
//
//  Created by Alfredo Luco on 07-02-21.
//

import Foundation

class StarredsInteractor: PresenterToInteractorStarredsProtocol {
    //MARK: - Memory debug
    
    deinit {
        print("starreds interactor dealloc")
    }
    
    //MARK: - Variables
    
    weak var presenter: InteractorToPresenterStarredsProtocol?
}
