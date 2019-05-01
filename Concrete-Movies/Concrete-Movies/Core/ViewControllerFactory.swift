//
//  ViewControllerFactory.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/28/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import UIKit

class ViewControllerFactory {
    private static var moviesServiceLocator = MoviesServiceLocator()
    
    class func viewController(type: ViewFactoryType)->UIViewController{
        switch type {
        case .popularMovies:
            let fetchPopularMoviesUseCase = moviesServiceLocator.fetchPopularMoviesUseCase
            let presenter = PopularMoviesPresenter(
                fetchPopularMoviesUseCase: fetchPopularMoviesUseCase,
                simpleMovieViewModelToModelMapper: moviesServiceLocator.simpleMovieViewModelToModelMapper)
            let viewController = PopularMoviesViewController(
                datasource: PopularMoviesDataSource(),
                presenter: presenter
            )
            return viewController
        case .movieDetail:
            let presenter = MovieDetailsPresenter(
                fetchMovieDetailsUseCase: moviesServiceLocator.fetchMovieDetailsUseCase,
                movieDetailViewModelToModelMapper: moviesServiceLocator.movieDetailViewModelToModelMapper)
            let viewController = MovieDetailsViewController(presenter: presenter)
            
            return viewController
        case .favoriteMovies:
            let presenter = FavoriteMoviesPresenter(
                fetchFavoritedMoviesUseCase: moviesServiceLocator.fetchFavoritedMoviesUseCase,
                favoriteMovieViewModelToModelMapper: moviesServiceLocator.favoriteMovieViewModelToModelMapper
            )
            let viewController = FavoriteMoviesViewController(datasource: FavoriteMoviesDataSource(),
                                                              presenter: presenter)
            
            return viewController
        }
    }
}
