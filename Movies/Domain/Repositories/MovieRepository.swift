//
//  MovieRepository.swift
//  Movies
//
//  Created by Pedro on 23-07-24.
//

import Foundation
import Combine

protocol MovieRepository {
    func fetchMovies(page: Int) -> AnyPublisher<[Movie], Error>
}
