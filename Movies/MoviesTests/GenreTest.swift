//
//  GenreTest.swift
//  MoviesTests
//
//  Created by Alfredo Luco on 08-02-21.
//

import XCTest
@testable import Movies

class GenreTest: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //MARK: - Fetch Genres
    
    func testFetchGenres() {
        let promise = expectation(description: "200 OK")
        let worker = MovieDetailWorker(repo: CategoriesAPIRepository(), repo: MoviesCoreDataRepository())
        worker.fetchCategories { (result) in
            switch result {
            case .failure(let error):
                XCTFail(error.localizedDescription)
                break
            case .success(let categories):
                XCTAssert(categories.count > 0, "No categories found")
                promise.fulfill()
                break
            }
        }
        wait(for: [promise], timeout: 5.0)
    }
}
