//
//  MovieListCoordinator.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/9/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import UIKit

class MovieListCoordinator: Coordinator {
    
    weak var viewController: MovieListViewController?
    
    func start(movieRouter: HomeRouter, movieList: MovieListModel, title: String, searchQuery: String = "", catId: String?){
       
        let vm = MovieListViewModel.init(initialPage: 1, router: movieRouter, movieList: movieList, searchQuery: searchQuery, catId: catId)
        vm.coordinator = self
        let vc = MovieListViewController.init(viewModel: vm, title: title)
        self.viewController = vc
        self.navController.pushViewController(vc, animated: true)
        
        interceptor = AppNavigationInterceptor.init(coordinator: self, interceptController: vc)
        navController.delegate = interceptor
    }
    
    func showMovieList(router: HomeRouter, movieList: MovieListModel, controllerName: String, searchQuery: String = "", catId: String?){
        
        let newCoord = MovieListCoordinator.init(navigationController: navController, nameid: CoordinatorKeys.List.rawValue, parentdelegate: self)
        newCoord.start(movieRouter: router, movieList: movieList, title: controllerName, searchQuery: searchQuery, catId:  catId)
        addChildCoordinator(child: newCoord)
    }
    
    func showMovieDetail(id movieTodisplay: Int){
        let newCoord = MovieDetailCoordinator.init(navigationController: navController, nameid: CoordinatorKeys.Detail.rawValue, parentdelegate: self)
        newCoord.start(movieToDisplay: movieTodisplay)
        addChildCoordinator(child: newCoord)
    }
    
}
