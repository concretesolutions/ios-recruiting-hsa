//
//  MovieRepositoryImpl.swift
//  Movies
//
//  Created by Pedro on 23-07-24.
//

import Foundation
import Combine

class MovieRepositoryImpl: MovieRepository {
    let remoteDataSource: MovieServiceApi

    init(remoteDataSource: MovieServiceApi) {
        self.remoteDataSource = remoteDataSource
    }

    func fetchMovies(page: Int) -> AnyPublisher<[Movie], Error> {
        return remoteDataSource.fetchMovies(page: page)
    }
}
