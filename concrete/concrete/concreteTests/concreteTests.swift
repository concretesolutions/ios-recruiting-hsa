//
//  concreteTests.swift
//  concreteTests
//
//  Created by Andres Ortiz on 5/9/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import XCTest
@testable import concrete
import OHHTTPStubs

class concreteTests: XCTestCase {

    var loader : MTAMovieLoader?
    
    override func setUp() {
        loader = MTAMovieLoader.shared
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRPIMovieLoaderPopular() {
        
        let successExpectation = self.expectation(description: "success called")
        
        stub(condition: isHost("api.themoviedb.org")) { _ in
            let stubPath = OHPathForFile("wsresponsepopular.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }
        
        loader?.fetchMovies(kind: 1, page: 1, text: ""){
            (result: [Movie], success) in
            XCTAssertEqual(20, result.count)
            successExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    
    func testRPIMovieLoaderTopRated() {
        
        let successExpectation = self.expectation(description: "success called")
        
        stub(condition: isHost("api.themoviedb.org")) { _ in
            let stubPath = OHPathForFile("wsresponsetoprated.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }
        
        loader?.fetchMovies(kind: 1, page: 1, text: ""){
            (result: [Movie], success) in
            let movie = result.first
            XCTAssertEqual(movie?.title, "Dilwale Dulhania Le Jayenge")
            successExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
    }
    
    func testRPIMovieLoaderMovieSearch() {
        
        let successExpectation = self.expectation(description: "success called")
        
        stub(condition: isHost("api.themoviedb.org")) { _ in
            let stubPath = OHPathForFile("wsresponseserach.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }
        
        loader?.fetchMovies(kind: 1, page: 1, text: "Captain Marvel"){
            (result: [Movie], success) in
            let movie = result.first
            XCTAssertEqual(movie?.title, "Captain Marvel")
            successExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
