//
//  SyncGenresUseCase.swift
//  Movies
//
//  Created by Pedro on 26-07-24.
//

import Foundation
import Combine

protocol SyncGenresUseCase {
    func execute() -> AnyPublisher<Bool, Error>
}
