//
//  FavoriteMoviesView.swift
//  movieAppAccen
//
//  Created by Orlando Velasco on 22-10-23.
//

import SwiftUI

struct FavoriteMoviesView: View, FavoriteMoviesDisplayLogic {
    @State private var favoriteMovies: [FavoriteMovie] = []
    private let interactor = FavoriteMoviesInteractor()
    private let presenter = FavoriteMoviesPresenter()
    
    var body: some View {
        List(favoriteMovies, id: \.id) { movie in
            FavoriteCardMovieView(movie: movie)
                .swipeActions(edge: .trailing) {
                    Button(action: {
                        FavoriteMovieManager().removeFavorite(by: Int(movie.id))
                        loadFavoriteMovies()
                    }) {
                        Text("Unfavorite")
                    }
                    .tint(.red)
                }
        }
        .onAppear {
            loadFavoriteMovies()
        }
    }
    
    func loadFavoriteMovies() {
        let movies = interactor.fetchFavoriteMovies()
        displayFavoriteMovies(presenter.presentFavoriteMovies(movies))
    }
    
    func displayFavoriteMovies(_ movies: [FavoriteMovie]) {
        favoriteMovies = movies
    }
}
