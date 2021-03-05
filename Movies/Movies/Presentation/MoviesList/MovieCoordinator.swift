//
//  MovieCoordinator.swift
//  Movies
//
//  Created by Daniel Nunez on 03-03-21.
//

import UIKit

class MovieCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showMovieScene()
    }
}

extension MovieCoordinator {
    func showMovieScene() {
        let movieScene = MoviesFactory.makeMovieScene(delegate: self, coordinator: self)
        navigationController.pushViewController(movieScene, animated: false)
    }

    func showMovieDetail(with movie: Movie, delegate: MovieListRefresh) {
        let detail = MoviesFactory.makeDetailScene(movie, home: delegate)
        navigationController.present(detail, animated: true, completion: nil)
    }

    func showFavorites() {
        let favoriteScene = MoviesFactory.makeFavoriteScene(delegate: self)
        navigationController.pushViewController(favoriteScene, animated: true)
    }

    func update(movie _: Movie) {
        guard let vc = navigationController.viewControllers.first
            as? MovieListController else {
            return
        }
    }
}

extension MovieCoordinator: MovieListProtocol {
    func didSelect(_ movie: Movie, _ delegate: MovieListRefresh) {
        showMovieDetail(with: movie, delegate: delegate)
    }
}
