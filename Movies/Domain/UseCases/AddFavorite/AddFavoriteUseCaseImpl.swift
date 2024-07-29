//
//  AddFavoriteUseCaseImpl.swift
//  Movies
//
//  Created by Pedro on 24-07-24.
//

import Foundation
import Combine

class AddFavoriteUseCaseImpl: AddFavoriteUseCase {
    let favoriteRepository: FavoriteRepository

    init(favoriteRepository: FavoriteRepository) {
        self.favoriteRepository = favoriteRepository
    }

    func execute(movie: Movie) -> AnyPublisher<Void, Error> {
        return favoriteRepository.addFavorite(movie: movie)
    }
}
