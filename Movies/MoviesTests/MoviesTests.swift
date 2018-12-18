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

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
    
    func testGetFavoriteMovies(){
        DefaultsManager.shared.getFavorites()
        let favoriteMoviesArray = DefaultsManager.shared.favoriteMovies
        XCTAssert(favoriteMoviesArray.count > 0)
    }

}
