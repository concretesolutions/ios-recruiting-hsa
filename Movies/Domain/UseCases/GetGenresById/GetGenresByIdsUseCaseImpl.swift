//
//  GetGenresByIdsUseCaseImpl.swift
//  Movies
//
//  Created by Pedro on 26-07-24.
//

import Foundation
import Combine

class GetGenresByIdsUseCaseImpl: GetGenresByIdsUseCase {
    let genreRepository: GenreRepository

    init(genreRepository: GenreRepository) {
        self.genreRepository = genreRepository
    }

    func execute(ids: [Int]) -> AnyPublisher<[Genre], any Error> {
        return genreRepository.getGenres(by: ids)
    }
}
