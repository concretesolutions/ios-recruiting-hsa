//
//  MovieListHandler.swift
//  MoviesApp
//
//  Created by Hector Morales on 2/27/21.
//

import Foundation

protocol MovieListHandlerHandlerProtocol: class {
    func gotMovies(items: [Movie], currentPage: Int)
    func gotMoviesError()
}

class MovieListHandler {

    weak var dataSourceProtocol: MovieListHandlerHandlerProtocol?
    var favoritesAPI: FavoritesAPI!

    init(dataSource: MovieListHandlerHandlerProtocol) {
        self.dataSourceProtocol = dataSource
        favoritesAPI = FavoritesAPI()
    }

    func getMovies(page: Int) {
        MovieServices.getMovies(page: page, successBlock: { [weak self] response in
            guard let strongSelf = self else { return }
            let movies = strongSelf.checkFavoritesMovies(movies: response)
            strongSelf.dataSourceProtocol?.gotMovies(items: movies, currentPage: page)
        }, errorBlock: {
            self.dataSourceProtocol?.gotMoviesError()
        })
    }

    func checkFavoritesMovies(movies: [Movie]) -> [Movie] {
        guard let favoritesArray = favoritesAPI.loadFavorites() else { return movies}
        for movie in movies {
            movie.isFavorited = favoritesArray.contains(where: {$0.id == movie.id})
        }
        return movies
    }

}
