//
//  DetailMoviePresenter.swift
//  MoviesApp
//
//  Created by Hector Morales on 2/28/21.
//

import Foundation

protocol DetailMoviePresenterProtocol: class {
    func gotMovieProtocol(movie: Movie)
    func movieSavedSuccessfully()
}

class DetailMoviePresenter {

    weak var dataSourcePresenterProtocol: DetailMoviePresenterProtocol?
    var handler: DetailMovieHandler?
    var movie: Movie!

    init(movie: Movie, dataSource: DetailMoviePresenterProtocol) {
        self.movie = movie
        dataSourcePresenterProtocol = dataSource
        handler = DetailMovieHandler(dataSource: self)
        loadFullMovie()
    }

    func loadFullMovie() {
        guard let handler = handler else {return}
        let fullMovie = handler.loadFullMovie(movie: movie)
        dataSourcePresenterProtocol?.gotMovieProtocol(movie: fullMovie)
    }

    func saveMovieInFavorites(){
        guard let handler = handler else {return}
        handler.saveMovieInFavorite(movie: movie)
    }

}

extension DetailMoviePresenter: DetailMovieHandlerProtocol {
    func gotMovie(movie: Movie) {
        dataSourcePresenterProtocol?.gotMovieProtocol(movie: movie)
    }

    func gotSavedFavoriteSuccessfull() {
        dataSourcePresenterProtocol?.movieSavedSuccessfully()
    }

}
