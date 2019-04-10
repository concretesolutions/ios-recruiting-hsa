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

class MovieRouter {
    
    let presentingViewController: UIViewController
    
    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
}

extension MovieRouter: MovieRouterProtocol{
    
    func showMovieDetail(for viewModel: MovieViewModel) {
        guard let navigation = presentingViewController.navigationController else{ return }
        let dest  = MovieDetailViewController(nibName: "MovieDetailViewController", bundle: nil)
        dest.viewModel = viewModel
        navigation.show(dest, sender: nil)
        
    }
}
