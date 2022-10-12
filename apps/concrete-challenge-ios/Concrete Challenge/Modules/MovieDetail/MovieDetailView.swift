//
//  MovieDetailView.swift
//  Concrete Challenge
//
//  Created by Jonathan Pacheco on 11/10/22.
//

import SwiftUI

struct MovieDetailView: View {
    
    let movie: Movie
    @EnvironmentObject private var store: Store
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16.0) {
                AsyncMovieImageView(path: movie.backdropPath)
                    .aspectRatio(contentMode: .fit)
                HStack {
                    Text(movie.title)
                        .font(.system(size: 18.0))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    FavoriteMovieButton(movieId: movie.id)
                }
                Divider()
                Text(movie.releaseYear)
                    .font(.system(size: 18.0))
                    .frame(maxWidth: .infinity, alignment: .leading)
                if !movie.genreIds.isEmpty && !store.state.movie.genres.isEmpty {
                    Divider()
                    Text(store.state.movie.genres
                        .filter { movie.genreIds.contains($0.id) }
                        .map{ $0.name }
                        .joined(separator: ", "))
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                Divider()
                Text(movie.overview)
                    .font(.system(size: 14.0))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
            .padding()
            .navigation(title: movie.title)
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView {
            MovieDetailView(movie: Movie(
                adult: false,
                backdropPath: "/jsoz1HlxczSuTx0mDl2h0lxy36l.jpg",
                genreIds: [14, 28, 35],
                id: 616037,
                originalLanguage: "en",
                originalTitle: "Thor: Love and Thunder",
                overview: "After his retirement is interrupted by Gorr the God Butcher, a galactic killer who seeks the extinction of the gods, Thor Odinson enlists the help of King Valkyrie, Korg, and ex-girlfriend Jane Foster, who now wields Mjolnir as the Mighty Thor. Together they embark upon a harrowing cosmic adventure to uncover the mystery of the God Butcher’s vengeance and stop him before it’s too late.",
                popularity: 1905.408,
                posterPath: "/pIkRyD18kl4FhoCNQuWxWu5cBLM.jpg",
                releaseDate: "2022-07-06",
                title: "Thor: Love and Thunder",
                video: false,
                voteAverage: 6.8,
                voteCount: 4117
            ))
        }
    }
}
