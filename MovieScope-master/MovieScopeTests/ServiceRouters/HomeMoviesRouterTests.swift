//
//  HomeMoviesRouterTests.swift
//  MovieScopeTests
//
//  Created by Andrés Alexis Rivas Solorzano on 7/4/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import XCTest
@testable import MovieScope

class HomeMoviesRouterTests: XCTestCase {

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
        self.measure {
            
        }
    }
    
    func testSearchMovieServiceCall(){
        let promise = expectation(description: "testing search")
        let testRouter = HomeRouter.search(query: "Harry Potter", page: 1)
        let router = SearchQueryRouter.init(networkRouter: testRouter, catId: "Harry Potter")
        DataProvider.searchRequest(router: router) { (result: Result<MovieListModel, Error>) in
            switch result{
            case .success:
                promise.fulfill()
                break
            case .failure(let error):
                XCTFail(error.localizedDescription)
                break
            }
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    
    func testTopRatedMovieServiceCall(){
        let promise = expectation(description: "testing router toprated")
        let router = HomeRouter.topRated(page: 1)
        let queryRouter = MovieListQueryRouter.init(networkRouter: router, categoryId: "Top Rated")
        DataProvider.requestForData(router: queryRouter) { (result: Result<MovieListModel, Error>) in
            switch result{
            case .success:
                promise.fulfill()
                break
            case .failure(let responseError):
                XCTFail(responseError.localizedDescription)
                break
            }
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testPopularMoviesServiceCall(){
        let promise = expectation(description: "testing router popular")
        let router = HomeRouter.popular(page: 1)
        let queryRouter = MovieListQueryRouter.init(networkRouter: router, categoryId: "Popular")
        DataProvider.requestForData(router: queryRouter) { (result: Result<MovieListModel, Error>) in
            switch result{
            case .success:
                promise.fulfill()
                break
            case .failure(let responseError):
                XCTFail(responseError.localizedDescription)
                break
            }
        }
        waitForExpectations(timeout: 10.0, handler: nil)
    }

}
