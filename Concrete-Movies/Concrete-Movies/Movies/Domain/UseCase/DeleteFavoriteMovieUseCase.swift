//
//  DeleteFavoriteMovieUseCase.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 5/1/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import Foundation

struct DeleteFavoriteMovieUseCase {
    private let repository: MoviesRepository
    
    init(repository: MoviesRepository) {
        self.repository = repository
    }
    
    func execute(movieId: Int ){
        repository.deleteFavoriteMovie(with: movieId)
    }
}
