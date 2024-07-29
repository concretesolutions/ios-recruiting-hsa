//
//  GenreLocalDataSource.swift
//  Movies
//
//  Created by Pedro on 26-07-24.
//

import Foundation
import Combine

protocol GenreLocalDataSource {
    func save(genres: [Genre]) -> AnyPublisher<Void, Error>
    func getGenres() -> AnyPublisher<[GenreEntity], Error>
    func getGenres(by ids: [Int]) -> AnyPublisher<[GenreEntity], Error>
}
