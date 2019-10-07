//
//  FavoritesMoviesModule.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/2/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import UIKit

class FavoritesMoviesModule {
    
    let router: FavoriteMoviesRouter
    
    init(navigation: UINavigationController) {
        navigation.navigationBar.prefersLargeTitles = true
        self.router = FavoriteMoviesRouter(navigation: navigation)
        setupModule()
    }
    
    private func setupModule(){
        let tabBarItem = UITabBarItem(title: LocalizableStrings.favoriteMoviesTitle.localized,
                                      image: .favIcon,
                                      selectedImage: .favIcon)
        router.favoritesViewController.tabBarItem = tabBarItem
    }
}
