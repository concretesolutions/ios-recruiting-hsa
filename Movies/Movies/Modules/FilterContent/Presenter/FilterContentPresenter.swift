//
//  FilterContentPresenter.swift
//  Movies
//
//  Created by Alfredo Luco on 07-02-21.
//

import Foundation

class FilterContentPresenter: ViewToPresenterFilterContentProtocol {
    //MARK: - Memory debug
    
    deinit {
        print("filter content presenter dealloc")
    }
    
    //MARK: - Variables
    
    weak var view: PresenterToViewFilterContentProtocol?
    var interactor: PresenterToInteractorFilterContentProtocol?
    var router: PresenterToRouterFilterContentProtocol?
    var filterType: FilterContent = .years
    
    //MARK: - Fetch Content
    
    func fetchContent() {
        interactor?.fetchContent(filterType)
    }
    
}

//MARK: - Presentation Logic

extension FilterContentPresenter: InteractorToPresenterFilterContentProtocol {
    func fetchContentSuccessfull(_ content: [String]) {
        view?.fetchContentSuccessfull(content)
    }
    
    func failure(_ error: Error) {
        view?.failure(error)
    }
    
    
}
