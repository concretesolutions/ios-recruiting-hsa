//
//  MovieAppTests.swift
//  MovieAppTests
//
//  Created by Sebastian Diaz on 4/3/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import XCTest
@testable import MovieApp

class MovieAppTests: XCTestCase {

    var presenter: MoviePresenterProtocol!
    var interactor: TestMovieInteractor!
    var router: TestMovieRouter!
    
    override func setUp() {
        super.setUp()
        
        interactor = TestMovieInteractor()
        router = TestMovieRouter()
        presenter = MoviePresenter(movieInteractor: interactor, movieRouter: router)
    }
    
    func testRetrievesMovies() {

    }
    
    func testShowsMovieDetailScreen() {
        XCTAssertTrue(router.showMovieDetailCalled)
    }
    
}


class TestMovieRouter: MovieRouterProtocol {
    var showMovieDetailCalled = false
    
    
    func showMovieDetail(for viewModel: MovieViewModel) {
        showMovieDetailCalled = true
    }
    
}

class TestMovieInteractor: MovieInteractorProtocol {
    var movies: [Movie]?
    
    func getMovies(completion: ([Movie]?) -> Void) {
        completion([])
    }
}

