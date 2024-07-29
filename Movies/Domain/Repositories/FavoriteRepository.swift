//
//  FavoriteRepository.swift
//  Movies
//
//  Created by Pedro on 26-07-24.
//

import Foundation
import Combine

protocol FavoriteRepository {
    func fetchFavorites() -> AnyPublisher<[Movie], Error>
    func addFavorite(movie: Movie) -> AnyPublisher<Void, Error>
    func deleteFavorite(movie: Movie) -> AnyPublisher<Void, Error>
    func isFavorite(movie: Movie) -> AnyPublisher<Bool, Error>
}
