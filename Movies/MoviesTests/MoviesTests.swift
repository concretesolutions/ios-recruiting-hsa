//
//  MoviesTests.swift
//  MoviesTests
//
//  Created by Consultor on 12/12/18.
//  Copyright © 2018 Mavzapps. All rights reserved.
//

import XCTest
@testable import Movies

class MoviesTests: XCTestCase {

    var testMovie: Movie? = nil
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        if DefaultsManager.shared.favoriteMovies.count > 0 {
            testMovie = DefaultsManager.shared.favoriteMovies[0]
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetFavoriteMovies(){
        DefaultsManager.shared.getFavorites()
        let favoriteMoviesArray = DefaultsManager.shared.favoriteMovies
        XCTAssert(favoriteMoviesArray.count > 0)
    }
    
    func testSaveMovie(){
        if var movieToSave = testMovie {
            movieToSave.setFavorite()
            XCTAssert(movieToSave.isFavorite ?? false)
        } else {
            XCTFail()
        }
    }

}
