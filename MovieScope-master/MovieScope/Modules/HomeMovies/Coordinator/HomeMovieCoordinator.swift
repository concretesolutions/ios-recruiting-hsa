//
//  HomeMovieCoordinator.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/2/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import UIKit

class HomeMovieCoordinator: Coordinator{
    
    var homeViewController: HomeMovieViewController?
    
    override func start() {
        let viewModel = HomeViewModel.init(coordinator: self)
        let newVC = HomeMovieViewController.init(viewModel: viewModel)
        
        homeViewController = newVC
        navController.pushViewController(newVC, animated: true)
        
        interceptor = AppNavigationInterceptor.init(coordinator: self, interceptController: newVC)
        
        self.navController.delegate = interceptor
    }
    
    func showMovieDetail(id movieTodisplay: Int){
        
        let newCoord = MovieDetailCoordinator.init(navigationController: navController, nameid: CoordinatorKeys.Detail.rawValue, parentdelegate: self)
        newCoord.start(movieToDisplay: movieTodisplay)
        addChildCoordinator(child: newCoord)
    }
    
    
    func showMovieList(router: HomeRouter, movieList: MovieListModel, controllerName: String, searchQuery: String = "", catId: String?){
        
        let newCoord = MovieListCoordinator.init(navigationController: navController, nameid: CoordinatorKeys.List.rawValue, parentdelegate: self)
        newCoord.start(movieRouter: router, movieList: movieList, title: controllerName, searchQuery: searchQuery, catId:  catId)
        addChildCoordinator(child: newCoord)
    }
    
    
}
