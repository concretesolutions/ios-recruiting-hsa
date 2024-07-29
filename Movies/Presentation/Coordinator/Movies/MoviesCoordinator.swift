//
//  MoviesCoordinator.swift
//  Movies
//
//  Created by Pedro on 25-07-24.
//

import UIKit

class MoviesCoordinator: Coordinator {
    var navigationController: UINavigationController
    let getMoviesUseCase: GetMoviesUseCase
    let getFavoritesUseCase: GetFavoritesUseCase
    let deleteFavoriteUseCase: DeleteFavoriteUseCase
    let addFavoriteUseCase: AddFavoriteUseCase
    let isFavoriteUseCase: IsFavoriteMovieUseCase
    let getGenresByIdsUseCase: GetGenresByIdsUseCase

    init(navigationController: UINavigationController, 
         getMoviesUseCase: GetMoviesUseCase,
         getFavoritesUseCase: GetFavoritesUseCase,
         deleteFavoriteUseCase: DeleteFavoriteUseCase,
         getGenresByIdsUseCase: GetGenresByIdsUseCase,
         addFavoriteUseCase: AddFavoriteUseCase,
         isFavoriteUseCase: IsFavoriteMovieUseCase) {
        self.navigationController = navigationController
        self.getMoviesUseCase = getMoviesUseCase
        self.getFavoritesUseCase = getFavoritesUseCase
        self.deleteFavoriteUseCase = deleteFavoriteUseCase
        self.getGenresByIdsUseCase = getGenresByIdsUseCase
        self.addFavoriteUseCase = addFavoriteUseCase
        self.isFavoriteUseCase = isFavoriteUseCase
    }

    func start() {
        let moviesViewModel = MoviesViewModel(
            getMoviesUseCase: getMoviesUseCase,
            addFavoriteUseCase: addFavoriteUseCase,
            deleteFavoriteUseCase: deleteFavoriteUseCase,
            isFavoriteMovieUseCase: isFavoriteUseCase
        )

        let moviesViewController = MoviesViewController(
            viewModel: moviesViewModel,
            moviesCoordinator: self
        )
        navigationController.pushViewController(moviesViewController, animated: false)
        navigationController.tabBarItem = UITabBarItem(
            title: "Movies",
            image: UIImage(systemName: "list.bullet"),
            tag: 0
        )
    }

    func showMovieDetail(movie: Movie) {
        showMovieDetail(
            movie: movie,
            getGenresByIdsUseCase: getGenresByIdsUseCase,
            addFavoriteUseCase: addFavoriteUseCase,
            deleteFavoriteUseCase: deleteFavoriteUseCase,
            isFavoriteMovieUseCase: isFavoriteUseCase)
    }
}
