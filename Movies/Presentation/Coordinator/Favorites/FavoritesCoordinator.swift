//
//  FavoritesCoordinator.swift
//  Movies
//
//  Created by Pedro on 25-07-24.
//

import UIKit

class FavoritesCoordinator: Coordinator {
    var navigationController: UINavigationController
    let getFavoritesUseCase: GetFavoritesUseCase
    let deleteFavoriteUseCase: DeleteFavoriteUseCase
    let getGenresUseCase: GetGenresUseCase
    let getGenresByIdsUseCase: GetGenresByIdsUseCase
    let addFavoriteUseCase: AddFavoriteUseCase
    let isFavoriteUseCase: IsFavoriteMovieUseCase

    init(navigationController: UINavigationController, 
         getFavoritesUseCase: GetFavoritesUseCase,
         deleteFavoriteUseCase: DeleteFavoriteUseCase,
         getGenresUseCase: GetGenresUseCase,
         getGenresByIdsUseCase: GetGenresByIdsUseCase,
         addFavoriteUseCase: AddFavoriteUseCase,
         isFavoriteUseCase: IsFavoriteMovieUseCase) {
        self.navigationController = navigationController
        self.getFavoritesUseCase = getFavoritesUseCase
        self.deleteFavoriteUseCase = deleteFavoriteUseCase
        self.getGenresUseCase = getGenresUseCase
        self.getGenresByIdsUseCase = getGenresByIdsUseCase
        self.addFavoriteUseCase = addFavoriteUseCase
        self.isFavoriteUseCase = isFavoriteUseCase
    }

    func start() {
        let favoriteViewModel = FavoriteViewModel(
            getFavoritesUseCase: getFavoritesUseCase,
            deleteFavoriteUseCase: deleteFavoriteUseCase
        )
        let favoritesViewController = FavoritesViewController(
            viewModel: favoriteViewModel,
            favoritesCoordinator: self
        )
        navigationController.pushViewController(favoritesViewController, animated: false)
        navigationController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), tag: 1)
    }

    func showMovieDetail(movie: Movie) {
        showMovieDetail(movie: movie, 
                        getGenresByIdsUseCase: getGenresByIdsUseCase,
                        addFavoriteUseCase: addFavoriteUseCase,
                        deleteFavoriteUseCase: deleteFavoriteUseCase,
                        isFavoriteMovieUseCase: isFavoriteUseCase)
    }

    func showFavoriteFilters(
        year: String?,
        genre: Genre?,
        delegate: FavouriteFiltersDelegate?) {
            let viewController = FavoriteFiltersViewController(
                year: year,
                genre: genre,
                genreUseCase: getGenresUseCase,
                delegate: delegate
            )
            viewController.hidesBottomBarWhenPushed = true
            navigationController.pushViewController(
                viewController,
                animated: true
            )
        }
}
