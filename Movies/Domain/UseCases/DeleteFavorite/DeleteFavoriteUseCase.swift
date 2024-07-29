//
//  DeleteFavoriteUseCase.swift
//  Movies
//
//  Created by Pedro on 24-07-24.
//

import Foundation
import Combine

protocol DeleteFavoriteUseCase {
    func execute(movie: Movie) -> AnyPublisher<Void, Error>
}
