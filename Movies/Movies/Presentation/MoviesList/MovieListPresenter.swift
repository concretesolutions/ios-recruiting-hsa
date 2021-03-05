//
//  MovieListPresenter.swift
//  Movies
//
//  Created by Daniel Nunez on 04-03-21.
//

import Foundation

protocol MovieListProtocol: class {
    func didSelect(_ movie: Movie)
}

class MovieListPresenter {

    let view: MovieListView
    let service: MoviesService
    var favoriteMng: FavoriteManager!
    weak var delegate: MovieListProtocol?


    init(service: MoviesService, view: MovieListView, delegate: MovieListProtocol?) {
        self.service = service
        self.view = view
        self.delegate = delegate
        favoriteMng = FavoriteManager()
    }

    func getMovies(with page: Int) {
        service.fetchMovies(page, { response in

            let movies = self.validFavorites(movies: response)
            self.view.showMovies(movies: movies)

        }, errorCompletion: {
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