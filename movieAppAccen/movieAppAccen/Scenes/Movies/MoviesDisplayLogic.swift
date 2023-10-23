//
//  MoviesDisplayLogic.swift
//  movieAppAccen
//
//  Created by Orlando Velasco on 21-10-23.
//

protocol MoviesDisplayLogic {
    func displayFetchedMovies(viewModel: Movies.FetchMovies.ViewModel)
    func displayError(message: String)
}
