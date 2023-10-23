//
//  MoviesModels.swift
//  movieAppAccen
//
//  Created by Orlando Velasco on 21-10-23.
//
import Foundation

enum Movies {
    enum FetchMovies {
        struct Request {
        }

        struct Response {
            let movies: [Movie]
        }

        struct ViewModel {
            let displayedMovies: [DisplayedMovie]

            struct DisplayedMovie: Identifiable {
                let id: Int
                let title: String
                let overview: String
                let genreIds: [Int]
                let releaseDate: String
                let posterPath: String?
            }
        }
    }
}
