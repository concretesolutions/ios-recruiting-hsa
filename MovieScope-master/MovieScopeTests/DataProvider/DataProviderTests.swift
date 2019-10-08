//
//  DataProviderTests.swift
//  MovieScopeTests
//
//  Created by Andrés Alexis Rivas Solorzano on 7/13/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import XCTest
@testable import MovieScope
class DataProviderTests: XCTestCase {

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
    
    func testOffileSearch(){
        let testQuery = "Lion"
        let searchInCat = "Upcoming"
        let router = SearchQueryRouter.init(networkRouter: .upcoming(page: 1), catId: searchInCat)
        let results = DataProvider.fetchMoviesByCategories(catRouter: router, movieTitle: testQuery)
        
        XCTAssert(results.results.count > 0)
    }
    
    func testDataProviderBehavior_offLineCorrect(){
        //id para la pelicula El rey leon
        let exp = expectation(description: "Se recupero la data desde core data")
        let movieTestId = 420818
        let queryRouter = MovieDetailQueryRouter.init(networkRouter: .getDetail(movieId: movieTestId))
        
        DataProvider.fetchCoreData(router: queryRouter) { (result: Result<MovieDetailModel, Error>) in
            switch result{
            case .success(let retrievedData):
                exp.fulfill()
                XCTAssert(retrievedData.id == movieTestId)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
    }
    
    
    func testDataProviderBehavior_normallyCorrect(){
        
        let firstExp = expectation(description: "El servicio respondio la primera vez")
        let secondExp = expectation(description: "El servicio respondio la segunda vez")
        
        //id para la pelicula El rey leon
        let movieTestId = 420818
        let detailRouter = MovieDetailRouter.getDetail(movieId: movieTestId)
        let queryRouter = MovieDetailQueryRouter.init(networkRouter: detailRouter)
        
        DataProvider.requestForData(router: queryRouter) { (result: Result<MovieDetailModel,Error>) in
            switch result{
            case .success(_):
                firstExp.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        DataProvider.requestForData(router: queryRouter) { (result: Result<MovieDetailModel,Error>) in
            switch result{
            case .success(_):
                secondExp.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
        let results = DataBaseManager.shared.queryCoreData(MovieDetailModel.self, search: queryRouter.queryPredicate)
        XCTAssert(results.count == 1)
        XCTAssert(results.first?.id == movieTestId)
        
    }

}
