//
//  FavoriteMovieCardView.swift
//  Concrete Challenge
//
//  Created by Jonathan Pacheco on 12/10/22.
//

import SwiftUI

struct FavoriteMovieCardView: View {
    
    let movie: Movie
    
    var body: some View {
        HStack(spacing: 16.0) {
            AsyncMovieImageView(path: movie.posterPath)
                .frame(maxWidth: 120.0)
                .clipped()
            VStack(spacing: 16.0) {
                HStack {
                    Text(movie.title)
                        .lineLimit(1)
                        .font(.system(size: 16, weight: .bold))
                        .frame(maxWidth: .infinity)
                    Text(movie.releaseYear)
                }
                Text(movie.overview)
            }
        }
        .frame(maxHeight: 180.0)
    }
}

struct FavoriteMovieCardView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView {
            FavoriteMovieCardView(movie: Movie(
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
            .padding()
        }
    }
}
