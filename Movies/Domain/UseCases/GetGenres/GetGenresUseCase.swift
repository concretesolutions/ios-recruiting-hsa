//
//  GetGenresUseCase.swift
//  Movies
//
//  Created by Pedro on 23-07-24.
//

import Foundation
import Combine

protocol GetGenresUseCase {
    func execute() -> AnyPublisher<[Genre], Error>
}
