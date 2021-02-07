//
//  FilterContentInteractor.swift
//  Movies
//
//  Created by Alfredo Luco on 07-02-21.
//

import Foundation

class FilterContentInteractor: PresenterToInteractorFilterContentProtocol {
    //MARK: - Memory debug
    
    deinit {
        print("filter content interactor dealloc")
    }
    
    //MARK: - Variables
    
    weak var presenter: InteractorToPresenterFilterContentProtocol?
}
