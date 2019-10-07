//
//  MovieDetailRouter.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailRouter: Wireframe{
    
    var detailController: MovieDetailViewController!
    
    init(navigation: UINavigationController, movieId: Int, movieTitle: String) {
        super.init(navigation: navigation)
        detailController = MovieDetailViewController(router: self, movieId: movieId, movieTitle: movieTitle)
    }
    
    override func updateNavigationTitle() {
        detailController.title = detailController.movieTitle
    }
    
}
