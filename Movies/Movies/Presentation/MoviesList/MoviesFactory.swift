//
//  MoviesFactory.swift
//  Movies
//
//  Created by Daniel Nunez on 04-03-21.
//

import Foundation

struct MoviesFactory {
    static func makeMovieScene(delegate: MovieListProtocol?, coordinator: MovieCoordinator) -> MovieListController {
        let viewController = MovieListController()
        viewController.coordinator = coordinator
        let service = MoviesService()
        let presenter = MovieListPresenter(service: service, view: viewController, delegate: delegate)
        viewController.presenter = presenter
        return viewController
    }

    static func makeDetailScene(_ movie: Movie, home: MovieListRefresh) -> MovieDetailController {
        let viewController = MovieDetailController()
        viewController.home = home
        viewController.presenter = MovieDetailPresenter(movie: movie, movieDetail: viewController)
        viewController.modalPresentationStyle = .fullScreen

        return viewController
    }

    static func makeFavoriteScene(delegate: MovieCoordinator) -> FavoritesController {
        let viewController = FavoritesController()
        viewController.coordinator = delegate
        viewController.presenter = FavoritePresenter(favoriteController: viewController)
        viewController.modalPresentationStyle = .fullScreen

        return viewController
    }
}
