//
//  FavoriteMovieLocalDataSource.swift
//  Movies
//
//  Created by Pedro on 23-07-24.
//

import Foundation
import Combine

protocol FavoriteMovieLocalDataSource {
    func fetchFavorites() -> AnyPublisher<[FavoriteMovieEntity], Error>
    func addFavorite(movie: Movie) -> AnyPublisher<Void, Error>
    func deleteFavorite(movie: Movie) -> AnyPublisher<Void, Error>
    func isFavorite(movie: Movie) -> AnyPublisher<Bool, Error>
}
