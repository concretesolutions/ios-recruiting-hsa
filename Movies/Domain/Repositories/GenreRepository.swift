//
//  GenreRepository.swift
//  Movies
//
//  Created by Pedro on 26-07-24.
//

import Foundation
import Combine

protocol GenreRepository {
    func syncFromRemoteGenres() -> AnyPublisher<Bool, Error>
    func getGenres() -> AnyPublisher<[Genre], Error>
    func getGenres(by ids: [Int]) -> AnyPublisher<[Genre], Error>
}
