//
//  GetFavoritesUseCaseImpl.swift
//  Movies
//
//  Created by Pedro on 24-07-24.
//

import Foundation
import Combine

class GetFavoritesUseCaseImpl: GetFavoritesUseCase {
    let favoriteRepository: FavoriteRepository

    init(favoriteRepository: FavoriteRepository) {
        self.favoriteRepository = favoriteRepository
    }

    func execute() -> AnyPublisher<[Movie], any Error> {
        return favoriteRepository.fetchFavorites()
    }
}
