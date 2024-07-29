//
//  GetFavoritesUseCase.swift
//  Movies
//
//  Created by Pedro on 24-07-24.
//

import Foundation
import Combine

protocol GetFavoritesUseCase {
    func execute() -> AnyPublisher<[Movie], Error>
}
