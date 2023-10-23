//
//  MovieCardView.swift
//  movieAppAccen
//
//  Created by Orlando Velasco on 21-10-23.
//

import SwiftUI

struct MovieCardView: View {
    var movie: Movies.FetchMovies.ViewModel.DisplayedMovie
    @State private var isFavorite: Bool = false
    
    var body: some View {
        NavigationLink(destination: MovieDetailView(movie: movie)) {
            
            VStack(spacing: 0) {
                Spacer()
                HStack{
                    if let posterPath = movie.posterPath {
                        ImageView(url: posterPath).frame(height: 190)
                    } else {
                        Image("defaultImage")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 190)
                    }
                }
                HStack {
                    Spacer()
                    
                    Text(movie.title)
                        .fontWeight(.medium)
                        .frame(height: 60)
                        .foregroundColor(Color.black)
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
                .background(Color.gray)
            }
        }
        .frame(width: 180, height: 250)
        .onAppear {
            isFavorite = FavoriteMovieManager().isFavorite(movieId: movie.id)
        }
    }
}
