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

    init(dataSource: MovieListHandlerHandlerProtocol) {
        self.dataSourceProtocol = dataSource
    }

    func getMovies(page: Int) {
        MovieServices.getMovies(page: page, successBlock: { [weak self] response in
            self?.dataSourceProtocol?.gotMovies(items: response, currentPage: page)
        }, errorBlock: {
            self.dataSourceProtocol?.gotMoviesError()
        })
    }

}
