//
//  MovieDetailRouterTest.swift
//  MovieScopeTests
//
//  Created by Andrés Alexis Rivas Solorzano on 7/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import XCTest
@testable import MovieScope

class MovieDetailRouterTest: XCTestCase {

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
    
    func testGetMovieImagesServiceCall_isCorrect(){
        let movieIdForTesting = 429617
        let testRouter = MovieDetailRouter.getImages(movieId: movieIdForTesting)
        let promise = expectation(description: "Router funcional get detail")
        let queryRouter = MovieDetailQueryRouter.init(networkRouter: testRouter)
        DataProvider.requestForData(router: queryRouter) { (result: Result<MovieImagesModel, Error>) in
            switch result{
            case .success(_):
                promise.fulfill()
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
                break
            }
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testGetMovieVideosServiceCall_isCorrect(){
        let movieIdForTesting = 429617
        let testRouter = MovieDetailRouter.getVideos(movieId: movieIdForTesting)
        let promise = expectation(description: "Router funcional get detail")
        let queryRouter = MovieDetailQueryRouter.init(networkRouter: testRouter)
        DataProvider.requestForData(router: queryRouter) { (result: Result<MovieVideoModel, Error>) in
            switch result{
            case .success(_):
                promise.fulfill()
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
                break
            }
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testGetMovieDetailServiceCall_isCorrect(){
        let movieIdForTesting = 429617
        let testRouter = MovieDetailRouter.getDetail(movieId: movieIdForTesting)
        let promise = expectation(description: "Router funcional get detail")
        let queryRouter = MovieDetailQueryRouter.init(networkRouter: testRouter)
        DataProvider.requestForData(router: queryRouter) { (result: Result<MovieDetailModel, Error>) in
            switch result{
            case .success(_):
                promise.fulfill()
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
                break
            }
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }

}
