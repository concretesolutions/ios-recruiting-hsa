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

    func showMovieDetail(with movie: Movie) {
        let detail = MoviesFactory.makeDetailScene(movie)
        navigationController.present(detail, animated: true, completion: nil)
    }

}

extension MovieCoordinator: MovieListProtocol {
    func didSelect(_ movie: Movie) {
        showMovieDetail(with: movie)
    }
}
