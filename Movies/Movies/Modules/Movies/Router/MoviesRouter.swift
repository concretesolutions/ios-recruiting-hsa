//
//  MoviesRouter.swift
//  Movies
//
//  Created by Alfredo Luco on 05-02-21.
//

import Foundation
import UIKit

class MoviesRouter: PresenterToRouterMoviesProtocol {
    //MARK: - Debug memory release
    
    deinit {
        print("Movies Router Dealloc")
    }
    
    static func createModule() -> MoviesViewController {
        let vc = MoviesViewController(nibName: String(describing: MoviesViewController.self), bundle: Bundle(for: MoviesViewController.self))
        let presenter: ViewToPresenterMoviesProtocol & InteractorToPresenterMoviesProtocol = MoviesPresenter()
        let interactor: PresenterToInteractorMoviesProtocol = MoviesInteractor()
        let router: PresenterToRouterMoviesProtocol = MoviesRouter()
        presenter.view = vc
        vc.presenter = presenter as! MoviesPresenter
        presenter.interactor = interactor
        presenter.router = router
        vc.title = "Movies"
        let item = UITabBarItem(title: "Movies", image: UIImage(named: "ic_list"), tag: 9)
        vc.tabBarItem = item
        return vc
    }
}
