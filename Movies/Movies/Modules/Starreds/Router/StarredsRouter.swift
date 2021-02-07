//
//  StarredsRouter.swift
//  Movies
//
//  Created by Alfredo Luco on 07-02-21.
//

import Foundation
import UIKit

class StarredsRouter: PresenterToRouterStarredsProtocol {
    //MARK: - Memory debug
    
    deinit {
        print("starreds router dealloc")
    }
    
    static func createModule() -> StarredsViewController {
        let vc = StarredsViewController(nibName: String(describing: StarredsViewController.self), bundle: Bundle(for: StarredsViewController.self))
        let presenter: ViewToPresenterStarredsProtocol & InteractorToPresenterStarredsProtocol = StarredsPresenter()
        let interactor: PresenterToInteractorStarredsProtocol = StarredsInteractor()
        let router: PresenterToRouterStarredsProtocol = StarredsRouter()
        vc.presenter = presenter as! StarredsPresenter
        presenter.view = vc
        presenter.interactor = interactor
        interactor.presenter = presenter
        presenter.router = router
        vc.title = "Movies"
        vc.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "ic_star_on"), tag: 9)
        return vc
    }
}
