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
    
    //MARK: - 1er test: Obtener los generos
    
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
    
    //MARK: - 2do test: Obtener los generos con un arreglo vacío de ids
    
    func testReduceAndMatchGenresWithNoIds() {
        let promise = expectation(description: "200 OK")
        execCategoriesWithGenres([], promise) { (genres) -> Bool in
            genres.count == 0
        }
        wait(for: [promise], timeout: 2.0)
    }
    
    //MARK: - 3er test: Obtener los generos con ids invalidos
    
    func testReduceAndMatchWithInvalidIDS() {
        let promise = expectation(description: "200 OK")
        execCategoriesWithGenres([-1001,-999,231456758], promise) { (genres) -> Bool in
            genres.count == 0
        }
        wait(for: [promise], timeout: 2.0)
    }
    
    //MARK: - 4to test: Obtener los generos con un id
    
    func testReduceAndMatchWithOneID() {
        let promise = expectation(description: "200 OK")
        execCategoriesWithGenres([14], promise) { (genres) -> Bool in
            genres.count == 1
        }
        wait(for: [promise], timeout: 2.0)
    }
    
    //MARK: - 5to test: Obtener los generos con ids validos
    
    func testReduceAndMatchWithMultiplesIDS() {
        let promise = expectation(description: "200 OK")
        execCategoriesWithGenres([14,28,12], promise) { (genres) -> Bool in
            genres.count > 0
        }
        wait(for: [promise], timeout: 2.0)
    }
    
    func execCategoriesWithGenres(_ ids: [Int], _ promise: XCTestExpectation, _ assertion: @escaping (_ categories: [String]) -> Bool) {
        let worker = MovieDetailWorker(repo: CategoriesAPIRepository(), repo: MoviesCoreDataRepository())
        worker.fetchCategories { (result) in
            switch result {
            case .failure(let error):
                XCTFail(error.localizedDescription)
                break
            case .success(let categories):
                let genres = self.reduceGenres(categories, ids)
                let assertion = assertion(genres)
                XCTAssert(assertion, "Test failed")
                promise.fulfill()
                break
            }
        }
    }
    
    func reduceGenres(_ categories: [Movies.Category], _ ids: [Int]) -> [String] {
        return categories.filter { (cat) -> Bool in
            return (ids.contains(where: { $0 == cat.id }))
        }.compactMap({ $0.name })
    }
}
