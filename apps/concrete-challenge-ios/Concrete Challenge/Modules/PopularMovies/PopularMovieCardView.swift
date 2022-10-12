//
//  PopularMovieCardView.swift
//  Concrete Challenge
//
//  Created by Jonathan Pacheco on 11/10/22.
//

import SwiftUI

struct PopularMovieCardView: View {
    
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }

    var body: some View {
        ZStack {
            AsyncMovieImageView(path: movie.posterPath)
            VStack {
                Spacer()
                HStack {
                    Text(movie.title)
                        .lineLimit(1)
                        .foregroundColor(Color.white)
                        .font(.system(size: 14, weight: .bold))
                        .frame(maxWidth: .infinity)
                    FavoriteMovieButton(movieId: movie.id)
                        .frame(width: 24.0, height: 24.0)
                        .padding(.trailing, 8.0)
                }
                .frame(maxWidth: .infinity, maxHeight: 44.0)
                .background(Color.black.opacity(0.8))
                    
            }
        }
    }
}

struct PopularMovieCardView_Previews: PreviewProvider {
    
    static var previews: some View {
        PreviewView {
            PopularMovieCardView(
                movie: Movie(
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
                )
            )
            .padding()
        }
    }
}
