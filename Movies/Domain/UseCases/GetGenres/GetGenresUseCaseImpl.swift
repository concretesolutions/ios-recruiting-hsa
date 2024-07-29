//
//  GetGenresUseCaseImpl.swift
//  Movies
//
//  Created by Pedro on 23-07-24.
//

import Foundation
import Combine

class GetGenresUseCaseImpl: GetGenresUseCase {
    let genreRepository: GenreRepository

    init(genreRepository: GenreRepository) {
        self.genreRepository = genreRepository
    }

    func execute() -> AnyPublisher<[Genre], any Error> {
        return genreRepository.getGenres()
    }
}
