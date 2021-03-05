//
//  MovieListPresenter.swift
//  Movies
//
//  Created by Daniel Nunez on 04-03-21.
//

import Foundation

protocol MovieListProtocol: class {
    func didSelect(_ movie: Movie, _ delegate: MovieListRefresh)
}

class MovieListPresenter {

    let view: MovieListView
    let service: MoviesService
    var favoriteMng: CacheManager!
    weak var delegate: MovieListProtocol?

    init(service: MoviesService, view: MovieListView, delegate: MovieListProtocol?) {
        self.service = service
        self.view = view
        self.delegate = delegate
        favoriteMng = CacheManager()
    }

    func getMovies(with page: Int) {
        self.view.loading()
        service.fetchMovies(page, { response in

            let movies = self.validFavorites(movies: response)
            self.view.showMovies(movies: movies)
            self.view.finish()

        }, errorCompletion: {
            self.view.finish()
            self.view.showError()
        })
    }

    func validFavorites(movies: [Movie]) -> [Movie] {
        guard let temp = favoriteMng.getFavorites() else {
            return movies
        }

        for item in movies {
            item.isFavorite = temp.contains(where: { $0.id == item.id })
        }

        return movies
    }


}
