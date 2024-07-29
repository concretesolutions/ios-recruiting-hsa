//
//  GenreRepositoryImpl.swift
//  Movies
//
//  Created by Pedro on 26-07-24.
//

import Foundation
import Combine

class GenreRepositoryImpl: GenreRepository {
    let remoteDataSource: MovieServiceApi
    let localDataSource: GenreLocalDataSource

    init(remoteDataSource: MovieServiceApi, localDataSource: GenreLocalDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }

    func syncFromRemoteGenres() -> AnyPublisher<Bool, Error> {
        return remoteDataSource
            .fetchGenres()
            .flatMap { [localDataSource] genres in
                localDataSource.save(genres: genres)
            }.map { true }
            .eraseToAnyPublisher()
    }

    func getGenres() -> AnyPublisher<[Genre], Error> {
        return localDataSource
            .getGenres()
            .map { $0.compactMap { $0.toDomain} }
            .eraseToAnyPublisher()
    }

    func getGenres(by ids: [Int]) -> AnyPublisher<[Genre], any Error> {
        return localDataSource
            .getGenres(by: ids)
            .map { $0.compactMap { $0.toDomain} }
            .eraseToAnyPublisher()
    }
}
