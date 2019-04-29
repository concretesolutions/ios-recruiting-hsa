//
//  FetchPopularMoviesUseCase.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/27/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import Foundation

struct FetchPopularMoviesUseCase {
    
    private let repository: MoviesRepository
    
    init(repository: MoviesRepository) {
        self.repository = repository
    }
    
    func execute(completionHandler: @escaping ([SimpleMovie]?, Error?)-> Void ){
        repository.popularMovies { (movies, error) in
            completionHandler(movies, error)
        }
    }
}
