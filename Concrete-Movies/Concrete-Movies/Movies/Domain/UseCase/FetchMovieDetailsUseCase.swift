//
//  FetchMovieDetailsUseCase.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/29/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import Foundation

struct FetchMovieDetailsUseCase{
    private let repository: MoviesRepository
    
    init(repository: MoviesRepository) {
        self.repository = repository
    }
    
    func execute(movieId: String, completionHandler: @escaping (MovieDetails?, Error?)-> Void ){
        repository.movieDetail(movieId: movieId) { (movieDetails, error) in
            completionHandler(movieDetails, error)
        }
    }
}
