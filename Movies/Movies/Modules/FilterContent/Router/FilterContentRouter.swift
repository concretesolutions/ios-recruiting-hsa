//
//  FilterContentRouter.swift
//  Movies
//
//  Created by Alfredo Luco on 07-02-21.
//

import Foundation

class FilterContentRouter: PresenterToRouterFilterContentProtocol {
    //MARK: - Memory debug
    
    deinit {
        print("filter content router dealloc")
    }
    
    static func createModule(_ contentType: FilterContent) -> FilterContentViewController {
        let vc = FilterContentViewController(nibName: String(describing: FilterContentViewController.self), bundle: Bundle(for: FilterContentViewController.self))
        let presenter: ViewToPresenterFilterContentProtocol & InteractorToPresenterFilterContentProtocol = FilterContentPresenter()
        let interactor: PresenterToInteractorFilterContentProtocol = FilterContentInteractor()
        let router: PresenterToRouterFilterContentProtocol = FilterContentRouter()
        presenter.view = vc
        vc.presenter = presenter as! FilterContentPresenter
        presenter.interactor = interactor
        interactor.presenter = presenter
        presenter.router = router
        presenter.filterType = contentType
        vc.title = contentType == .years ? "Year" : "Genre"
        return vc
    }
}
