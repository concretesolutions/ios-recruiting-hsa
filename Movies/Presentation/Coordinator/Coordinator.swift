//
//  Coordinator.swift
//  Movies
//
//  Created by Pedro on 25-07-24.
//

import UIKit

@MainActor
protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

extension Coordinator {
    func showMovieDetail(
        movie: Movie,
        getGenresByIdsUseCase: GetGenresByIdsUseCase,
        addFavoriteUseCase: AddFavoriteUseCase,
        deleteFavoriteUseCase: DeleteFavoriteUseCase,
        isFavoriteMovieUseCase: IsFavoriteMovieUseCase) {
            // Regretting about not choosing automatic injection
            let viewModel = MovieDetailViewModel(
                addFavoriteUseCase: addFavoriteUseCase,
                deleteFavoriteUseCase: deleteFavoriteUseCase,
                isFavoriteMovieUseCase: isFavoriteMovieUseCase)
            let detailViewController = MovieDetailViewController(
                movie: movie, 
                viewModel: viewModel,
                getGenresByIdsUseCase: getGenresByIdsUseCase
            )
            detailViewController.hidesBottomBarWhenPushed = true
            navigationController.pushViewController(
                detailViewController,
                animated: true
        )
    }
}
