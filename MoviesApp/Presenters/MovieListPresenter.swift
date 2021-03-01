//
//  MovieListPresenter.swift
//  MoviesApp
//
//  Created by Hector Morales on 2/27/21.
//

import Foundation

protocol MovieListPresenterProtocol: class {
    func gotMovies(items: [Movie], currentPage: Int)
    func gotError()
    func startAnimating()
    func stopAnimating()
}

class MovieListPresenter {

    weak var dataSourcePresenterProtocol: MovieListPresenterProtocol?
    var movieListHandler: MovieListHandler!

    init(dataSource: MovieListPresenterProtocol) {
        dataSourcePresenterProtocol = dataSource
        movieListHandler = MovieListHandler(dataSource: self)
        getMovies(page: 1)
    }

    func getMovies(page: Int) {
        dataSourcePresenterProtocol?.startAnimating()
        movieListHandler.getMovies(page: page)
    }

    func refreshingFavorites(movies: [Movie]) -> [Movie] {
        return movieListHandler.checkFavoritesMovies(movies: movies)
    }

}

extension MovieListPresenter: MovieListHandlerHandlerProtocol {
    func gotMovies(items: [Movie], currentPage: Int) {
        dataSourcePresenterProtocol?.stopAnimating()
        dataSourcePresenterProtocol?.gotMovies(items: items, currentPage: currentPage)
    }

    func gotMoviesError() {
        dataSourcePresenterProtocol?.stopAnimating()
        dataSourcePresenterProtocol?.gotError()
    }

}
