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
    
    var view: PopularMoviesViewMock!
    var repo: MoviesRepositoryMock!

    override func setUp() {
        super.setUp()
        
        let moviesServiceLocator = MoviesServiceLocator()
        
        view = PopularMoviesViewMock()
        repo = MoviesRepositoryMock()
        
        sut = PopularMoviesPresenter(
            fetchPopularMoviesUseCase: FetchPopularMoviesUseCase(repository: repo),
            simpleMovieViewModelToModelMapper: moviesServiceLocator.simpleMovieViewModelToModelMapper,
            saveFavoriteMovieUseCase: SaveFavoriteMovieUseCase(repository: repo),
            favoriteMovieViewModelToModelMapper: moviesServiceLocator.favoriteMovieViewModelToModelMapper
        )
        
        sut.popularMoviesView = view
    }

    override func tearDown() {
        sut = nil
        view = nil
        repo = nil
        
        super.tearDown()
    }

    func testFetchMovies(){
        repo.success = true
        
        sut.fetchMovies()
        XCTAssertTrue(view.isCalled)
    }
}
