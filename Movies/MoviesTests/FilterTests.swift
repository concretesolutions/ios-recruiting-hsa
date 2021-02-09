//
//  FilterTests.swift
//  MoviesTests
//
//  Created by Alfredo Luco on 09-02-21.
//

import XCTest
@testable import Movies

class FilterTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //MARK: - 1er test: Filtrar sin filtros
    
    func testFilterWithNoFilters() {
        let filterSet: [Filter<String>] = []
        let promise = expectation(description: "200 OK")
        execFilterUseCase(filterSet, promise) { (movies) -> Bool in
            movies.count > 0
        }
        wait(for: [promise], timeout: 2.0)
    }
    
    //MARK: - 2do test: Filtrar por genero
    
    func testFilterWithGenre() {
        let filterGenre = Filter<String>("Genre")
        filterGenre.value = "Action"
        let promise = expectation(description: "200 OK")
        execFilterUseCase([filterGenre], promise) { (movies) -> Bool in
            movies.count > 0
        }
        wait(for: [promise], timeout: 5.0)
    }
    
    //MARK: - 3er test: Filtrar por año
    
    func testFilterWithYear() {
        let filterYear = Filter<String>("Date")
        filterYear.value = "2020"
        let promise = expectation(description: "200 OK")
        execFilterUseCase([filterYear], promise) { (movies) -> Bool in
            movies.count > 0
        }
        wait(for: [promise], timeout: 2.0)
    }
    
    //MARK: - 4to test: Filtrar por año y por genero
    
    func testFilterWithYearAndGenre() {
        let filterGenre = Filter<String>("Genre")
        filterGenre.value = "Adventure"
        let filterYear = Filter<String>("Date")
        filterYear.value = "2020"
        let promise = expectation(description: "200 OK")
        execFilterUseCase([filterYear,filterGenre], promise) { (movies) -> Bool in
            movies.count > 0
        }
        wait(for: [promise], timeout: 2.0)
    }
    
    //MARK: - 5to test: Filtrar con un año erroneo
    
    func testFilterWithInvalidYear() {
        let filterYear = Filter<String>("Date")
        filterYear.value = "2079"
        let promise = expectation(description: "200 OK")
        execFilterUseCase([filterYear], promise) { (movies) -> Bool in
            movies.count == 0
        }
        wait(for: [promise], timeout: 2.0)
    }
    
    //MARK: - 6to test: Filtrar con un genero erroneo
    
    func testFilterWithInvalidGenre() {
        let filterGenre = Filter<String>("Genre")
        filterGenre.value = "foo"
        let promise = expectation(description: "200 OK")
        execFilterUseCase([filterGenre], promise) { (movies) -> Bool in
            movies.count == 0
        }
        wait(for: [promise], timeout: 2.0)
    }
    
    //MARK: - 7mo test: Filtrar con un año erroneo pero un genero valido
    
    func testFilterWithValidGenreButInvalidYear() {
        let filterGenre = Filter<String>("Genre")
        filterGenre.value = "Adventure"
        let filterYear = Filter<String>("Date")
        filterYear.value = "20300"
        let promise = expectation(description: "200 OK")
        execFilterUseCase([filterYear,filterGenre], promise) { (movies) -> Bool in
            movies.count == 0
        }
        wait(for: [promise], timeout: 2.0)
    }
    
    //MARK: - 8vo test: Filtrar con un genero erroneo pero con un año valido
    
    func testFilterWithValidYearButInvalidGenre() {
        let filterGenre = Filter<String>("Genre")
        filterGenre.value = "foo"
        let filterYear = Filter<String>("Date")
        filterYear.value = "2020"
        let promise = expectation(description: "200 OK")
        execFilterUseCase([filterYear,filterGenre], promise) { (movies) -> Bool in
            movies.count == 0
        }
        wait(for: [promise], timeout: 2.0)
    }
    
    //MARK: - 9no test: Filtrar con un genero erroneo y un año erroneo
    
    func testFilterWithInvalidYearAndInvalidGenre() {
        let filterGenre = Filter<String>("Genre")
        filterGenre.value = "foo"
        let filterYear = Filter<String>("Date")
        filterYear.value = "2023302"
        let promise = expectation(description: "200 OK")
        execFilterUseCase([filterYear,filterGenre], promise) { (movies) -> Bool in
            movies.count == 0
        }
        wait(for: [promise], timeout: 2.0)
    }
    
    func execFilterUseCase(_ filters: [Filter<String>], _ promise: XCTestExpectation, _ assertion: @escaping (_ movies: [Movie]) -> Bool) {
        let worker = StarredsWorker(MoviesCoreDataRepository())
        worker.filterMovies(filters) { (result) in
            switch result {
            case .failure(let error):
                XCTFail(error.localizedDescription)
                break
            case .success(let movies):
                XCTAssert(assertion(movies), "ERROR!")
                promise.fulfill()
                break
            }
        }
    }

}
