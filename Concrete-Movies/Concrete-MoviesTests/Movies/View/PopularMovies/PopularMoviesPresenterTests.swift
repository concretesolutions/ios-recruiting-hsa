//
//  PopularMoviesPresenterTests.swift
//  Concrete-MoviesTests
//
//  Created by Audel Dugarte on 5/2/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

@testable import Concrete_Movies
import XCTest

class PopularMoviesPresenterTests: XCTestCase {
    
    var sut: PopularMoviesPresenter!

    override func setUp() {
        super.setUp()
        
        let moviesServiceLocator = MoviesServiceLocator()
        
        sut = PopularMoviesPresenter(
            fetchPopularMoviesUseCase: moviesServiceLocator.fetchPopularMoviesUseCase,
            simpleMovieViewModelToModelMapper: moviesServiceLocator.simpleMovieViewModelToModelMapper,
            saveFavoriteMovieUseCase: moviesServiceLocator.saveFavoriteMovieUseCase,
            favoriteMovieViewModelToModelMapper: moviesServiceLocator.favoriteMovieViewModelToModelMapper
        )
    }

    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
