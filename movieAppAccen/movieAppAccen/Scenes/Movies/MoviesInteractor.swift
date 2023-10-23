//
//  MoviesInteractor.swift
//  movieAppAccen
//
//  Created by Orlando Velasco on 21-10-23.
//

import Foundation

protocol MoviesBusinessLogic {
    func fetchMovies(request: Movies.FetchMovies.Request)
}

class MoviesInteractor: MoviesBusinessLogic {
    var presenter: MoviesPresentationLogic?
    var worker: MoviesWorker = MoviesWorker()
    var genreManager: GenreManager = GenreManager.shared


    func fetchMovies(request: Movies.FetchMovies.Request) {
        if genreManager.genres.isEmpty {
            genreManager.fetchAndStoreGenres { error in
                if error == nil {
                    self.retrieveTopRatedMovies()
                } else {
                    self.presenter?.handleError(error: error)
                }
            }
        } else {
            self.retrieveTopRatedMovies()
        }
    }

    private func retrieveTopRatedMovies() {
        worker.fetchTopRatedMovies { movies, error in
            if let movies = movies {
                let response = Movies.FetchMovies.Response(movies: movies)
                self.presenter?.presentFetchedMovies(response: response)
            } else if let error = error {
                self.presenter?.handleError(error: error)
            }
        }
    }

}
