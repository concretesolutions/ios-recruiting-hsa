//
//  MovieDetailCoordinator.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/5/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailCoordinator: Coordinator{
    
    var viewController: MovieDetailViewController?
    
    func start(movieToDisplay: Int) {
        let viewModel = MovieDetailViewModel.init(movieId: movieToDisplay, coordinator: self)
        let viewController = MovieDetailViewController.init(viewModel: viewModel)
        self.viewController = viewController
        
        self.navController.pushViewController(viewController, animated: true)
        self.navController.presentTransparentNavigationBar()
        
        interceptor = AppNavigationInterceptor.init(coordinator: self, interceptController: viewController)
        navController.delegate = interceptor
    }
}
