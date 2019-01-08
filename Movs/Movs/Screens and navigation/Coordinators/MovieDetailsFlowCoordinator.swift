//
//  MovieDetailsCoordinator.swift
//  Movs
//
//  Created by Miguel Duran on 1/6/19.
//  Copyright © 2019 Miguel Duran. All rights reserved.
//

import UIKit

// MARK: MovieDetailsFlowCoordinator
class MovieDetailsFlowCoordinator: NSObject {
    weak var parent: Coordinator?
    
    func moviesViewControllerDidSelectMovieDetails(_ viewController: MoviesViewController) {
        viewController.performSegue(withIdentifier: MoviesViewControllerSegues.ShowMovieDetails.rawValue, sender: nil)
    }
}

// MARK: Coordinator
extension MovieDetailsFlowCoordinator: Coordinator {
    func configure(viewController: UIViewController) {
        parent?.configure(viewController: viewController)
    }
}

extension MovieDetailsFlowCoordinator {
    enum MoviesViewControllerSegues: String {
        case ShowMovieDetails
    }
}
