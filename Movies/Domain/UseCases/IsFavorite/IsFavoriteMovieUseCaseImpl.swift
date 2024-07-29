//
//  IsFavoriteMovieUseCaseImpl.swift
//  Movies
//
//  Created by Pedro on 24-07-24.
//

import Foundation
import Combine

class IsFavoriteMovieUseCaseImpl: IsFavoriteMovieUseCase {
    let favoriteRepository: FavoriteRepository

    init(favoriteRepository: FavoriteRepository) {
        self.favoriteRepository = favoriteRepository
    }

    func execute(movie: Movie) -> AnyPublisher<Bool, Error> {
        return favoriteRepository.isFavorite(movie: movie)
    }
}
