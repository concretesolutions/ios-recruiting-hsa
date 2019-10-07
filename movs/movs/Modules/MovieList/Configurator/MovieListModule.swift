//
//  MovieListModule.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/2/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import UIKit

class MovieListModule {
    
    let router: MovieListRouter

    init(rootNavigation: UINavigationController) {
        rootNavigation.navigationBar.prefersLargeTitles = true
        router = MovieListRouter(navigation: rootNavigation)
        setupModule()
    }
    
    private func setupModule(){
        let tabBarItem = UITabBarItem.init(title: LocalizableStrings.movieListTitle.localized,
                                           image: .listIcon,
                                           selectedImage: .listIcon)
        router.movieList.tabBarItem = tabBarItem
    }
}
