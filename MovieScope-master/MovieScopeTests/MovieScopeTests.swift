//
//  MovieScopeTests.swift
//  MovieScopeTests
//
//  Created by Andrés Alexis Rivas Solorzano on 7/2/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import XCTest
@testable import MovieScope

class MovieScopeTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    

    func testServiceLayer(){
        let promise = expectation(description: "testServiceLayer")
        typealias MovieResult = Result<MovieListModel, Error>
        let netRouter = HomeRouter.popular(page: 1)
        let queryRouter = MovieListQueryRouter.init(networkRouter: netRouter, categoryId: "Popular")
        DataProvider.requestForData(router: queryRouter) { (result: MovieResult) in
            switch result{
            case .success(_):
                promise.fulfill()
                break
            case .failure(let responseError):
                XCTFail(responseError.localizedDescription)
                break
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testCurrencyHelper(){
        let testData = 160000000
        let expectedResult = "$160,000,000.00"
        let obtainedResult = CurrencyHelper.getCurrencyValue(forInt: testData)
        XCTAssert(obtainedResult == expectedResult)
    }
    
    func testTimeHelper_Hour(){
        let testData = 129
        let expectedResult = "2 hr, 9 min"
        let obtainedResult = TimeHelper.getFormattedTime(fromMinutes: testData)
        XCTAssert(obtainedResult == expectedResult)
    }
    
    func testTimeHelper_Year(){
        let testData = "2019-07-12"
        let expectedResult = "2019"
        let obtainedResult = TimeHelper.getYearFromDate(dateString: testData)
        XCTAssert(obtainedResult == expectedResult)
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
