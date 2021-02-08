//
//  FiltersRouter.swift
//  Movies
//
//  Created by Alfredo Luco on 07-02-21.
//

import Foundation

class FiltersRouter: PresenterToRouterFiltersProtocol {
    //MARK: - Memory debug
    
    deinit {
        print("filters router dealloc")
    }
    
    //MARK: - Create Module
    
    static func createModule() -> FiltersViewController {
        let vc = FiltersViewController(nibName: String(describing: FiltersViewController.self), bundle: Bundle(for: FiltersViewController.self))
        let presenter: ViewToPresenterFiltersProtocol & InteractorToPresenterFiltersProtocol = FiltersPresenter()
        let interactor: PresenterToInteractorFiltersProtocol = FiltersInteractor()
        let router: PresenterToRouterFiltersProtocol = FiltersRouter()
        vc.presenter = presenter as! FiltersPresenter
        presenter.view = vc
        presenter.interactor = interactor
        interactor.presenter = presenter
        presenter.router = router
        vc.title = "Filters"
        return vc
    }
}
