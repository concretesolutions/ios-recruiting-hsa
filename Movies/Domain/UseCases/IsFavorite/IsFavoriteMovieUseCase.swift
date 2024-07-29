//
//  IsFavoriteMovieUseCase.swift
//  Movies
//
//  Created by Pedro on 24-07-24.
//

import Foundation
import Combine

protocol IsFavoriteMovieUseCase {
    func execute(movie: Movie) -> AnyPublisher<Bool, Error>
}
