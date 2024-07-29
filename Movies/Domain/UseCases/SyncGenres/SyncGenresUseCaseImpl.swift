//
//  SyncGenresUseCaseImpl.swift
//  Movies
//
//  Created by Pedro on 26-07-24.
//

import Foundation
import Combine

class SyncGenresUseCaseImpl: SyncGenresUseCase {
    let genreRepository: GenreRepository

    init(genreRepository: GenreRepository) {
        self.genreRepository = genreRepository
    }

    func execute() -> AnyPublisher<Bool, Error> {
        return genreRepository.syncFromRemoteGenres()
    }
}
