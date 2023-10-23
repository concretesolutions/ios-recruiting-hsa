//
//  MovieDetailView.swift
//  movieAppAccen
//
//  Created by Orlando Velasco on 21-10-23.
//

import SwiftUI

struct MovieDetailView: View {
    var movie: Movies.FetchMovies.ViewModel.DisplayedMovie
    @State private var isFavorite: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if let posterPath = movie.posterPath {
                ImageView(url: posterPath)
            } else {
                Image("defaultImage")
                    .resizable()
                    .scaledToFit()
                    .padding(.top, 20)
            }
            HStack{
                Text(movie.title)
                Spacer()
                Button(action: {
                    if isFavorite {
                        FavoriteMovieManager().removeFavorite(by: movie.id)
                    } else {
                        FavoriteMovieManager().addFavorite(movie: movie)
                    }
                    isFavorite.toggle()
                }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .font(.system(size: 25))
                        .foregroundColor(Color.black)
                        .padding(.trailing, 5)
                }
            }
            Divider().background(Color.black)
            Text(movie.releaseDate.split(separator: "-")[0])
            Divider().background(Color.black)
            let genreNames = movie.genreIds.compactMap { GenreManager.shared.genre(forID: $0)?.name }
            if !genreNames.isEmpty {
                Text(genreNames.joined(separator: ", "))
            }
            Divider().background(Color.black)
            Text(movie.overview)
            Spacer()
        }
        .padding()
        .onAppear {
            isFavorite = FavoriteMovieManager().isFavorite(movieId: movie.id)
        }
    }
}
