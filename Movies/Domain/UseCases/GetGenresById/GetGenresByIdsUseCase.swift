//
//  GetGenresByIdsUseCase.swift
//  Movies
//
//  Created by Pedro on 26-07-24.
//

import Foundation
import Combine

protocol GetGenresByIdsUseCase {
    func execute(ids: [Int]) -> AnyPublisher<[Genre], Error>
}
