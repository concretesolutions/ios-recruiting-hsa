//
//  GetMoviesUseCase.swift
//  Movies
//
//  Created by Pedro on 23-07-24.
//

import Foundation
import Combine

protocol GetMoviesUseCase {
    func execute(page: Int) -> AnyPublisher<[Movie], Error>
}
