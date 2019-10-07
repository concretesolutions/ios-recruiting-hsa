//
//  FavoriteMoviesRouter.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/2/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import UIKit

class FavoriteMoviesRouter: Wireframe {
    
    private (set) var favoritesViewController: FavoriteMoviesViewController!
    
    override init(navigation: UINavigationController) {
        super.init(navigation: navigation)
        self.favoritesViewController = FavoriteMoviesViewController(router: self)
        navigation.setViewControllers([favoritesViewController], animated: true)
    }
    
    override func updateNavigationTitle() {
        favoritesViewController.title = LocalizableStrings.favoriteMoviesTitle.localized
    }
    
    func setupFilterButton(){
        let filterButton = UIBarButtonItem.init(image: .filterIcon,
                                                style: .plain,
                                                target: favoritesViewController,
                                                action: #selector(favoritesViewController.showFilters))
        favoritesViewController.navigationItem.rightBarButtonItem = filterButton
    }
    
    func routeToFilters(filtersList: [FilterModel], delegate: FiltersSelectionDelegate){
        let router = FiltersRouter(navigation: navigation, filtersList: filtersList, delegate: delegate)
        router.presentFilters()
    }
    
}
