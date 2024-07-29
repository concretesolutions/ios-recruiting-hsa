//
//  FavoriteRepositoryImpl.swift
//  Movies
//
//  Created by Pedro on 26-07-24.
//

import Foundation
import Combine

class FavoriteRepositoryImpl: FavoriteRepository {
    let localDataSource: FavoriteMovieLocalDataSource

    init(localDataSource: FavoriteMovieLocalDataSource) {
        self.localDataSource = localDataSource
    }

    func fetchFavorites() -> AnyPublisher<[Movie], Error> {
        return localDataSource
            .fetchFavorites()
            .map {
                $0.compactMap { $0.toDomain }
            }
            .eraseToAnyPublisher()
    }

    func addFavorite(movie: Movie) -> AnyPublisher<Void, Error> {
        return localDataSource.addFavorite(movie: movie).eraseToAnyPublisher()
    }

    func deleteFavorite(movie: Movie) -> AnyPublisher<Void, Error> {
        return localDataSource.deleteFavorite(movie: movie).eraseToAnyPublisher()
    }

    func isFavorite(movie: Movie) -> AnyPublisher<Bool, Error> {
        return localDataSource.isFavorite(movie: movie)
    }
}
