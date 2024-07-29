//
//  DeleteFavoriteUseCaseImpl.swift
//  Movies
//
//  Created by Pedro on 24-07-24.
//

import Foundation
import Combine

class DeleteFavoriteUseCaseImpl: DeleteFavoriteUseCase {
    let favoriteRepository: FavoriteRepository

    init(favoriteRepository: FavoriteRepository) {
        self.favoriteRepository = favoriteRepository
    }

    func execute(movie: Movie) -> AnyPublisher<Void, any Error> {
        return favoriteRepository.deleteFavorite(movie: movie)
    }
}
