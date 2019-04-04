//
//  MovieRouter.swift
//  MovieApp
//
//  Created by Sebastian Diaz on 4/3/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import Foundation
import UIKit

protocol MovieRouterProtocol{
    func showMovieDetail(for viewModel: MovieViewModel)
}



class MovieRouter  : MovieRouterProtocol{
    
    let presentingViewController: UIViewController
    
    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    
    func showMovieDetail(for viewModel: MovieViewModel) {
        
    }
    
    
}
