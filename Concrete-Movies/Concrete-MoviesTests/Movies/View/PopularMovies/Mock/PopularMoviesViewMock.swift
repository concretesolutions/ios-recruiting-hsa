//
//  PopularMoviesViewMock.swift
//  Concrete-MoviesTests
//
//  Created by Audel Dugarte on 5/2/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import Foundation
@testable import Concrete_Movies

class PopularMoviesViewMock: PopularMoviesViewProtocol {
    var isCalled = false
    var calledWithError = false
    
    func show(movies: [SimpleMovieViewModel]) {
        isCalled = true
    }
    
    func show(error: Error) {
        calledWithError = true
    }
}
