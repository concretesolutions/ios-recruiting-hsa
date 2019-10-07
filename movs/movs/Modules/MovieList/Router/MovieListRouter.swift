//
//  MovieListRouter.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/2/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import UIKit

class MovieListRouter: Wireframe {
    
    private(set) var movieList: MovieListViewController!
    
    override init(navigation: UINavigationController) {
        super.init(navigation: navigation)
        self.movieList = MovieListViewController(router: self)
        navigation.setViewControllers([movieList], animated: true)
    }
    
    override func updateNavigationTitle(){
        movieList.title = LocalizableStrings.movieListTitle.localized
    }
    
}
