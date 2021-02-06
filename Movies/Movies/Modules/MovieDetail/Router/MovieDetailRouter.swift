//
//  MovieDetailRouter.swift
//  Movies
//
//  Created by Alfredo Luco on 05-02-21.
//

import Foundation

class MovieDetailRouter: PresenterToRouterMovieDetailProtocol {
    
    //MARK: - Memory debug
    
    deinit {
        print("Movie detail router dealloc")
    }
    
    static func createModule(_ id: Int32) -> MovieDetailViewController {
        let vc = MovieDetailViewController(nibName: String(describing: MovieDetailViewController.self), bundle: Bundle(for: MovieDetailViewController.self))
        let presenter: ViewToPresenterMovieDetailProtocol & InteractorToPresenterMovieDetailProtocol = MovieDetailPresenter()
        let interactor: PresenterToInteractorMovieDetailProtocol = MovieDetailInteractor()
        let router: PresenterToRouterMovieDetailProtocol = MovieDetailRouter()
        vc.presenter = presenter as! MovieDetailPresenter
        presenter.view = vc
        presenter.interactor = interactor
        interactor.presenter = presenter
        presenter.router = router
        presenter.movieID = id
        vc.title = "Movie"
        return vc
    }
    
}
