//
//  MoviesTests.swift
//  MoviesTests
//
//  Created by Alfredo Luco on 08-02-21.
//

import XCTest
@testable import Movies

class MoviesTests: XCTestCase {

    //MARK: - Setup
    
    override func setUp() {
        super.setUp()
    }
    
    //MARK: - Tear Down
    
    override func tearDown() {
        super.tearDown()
    }

    //MARK: - 1er test: Obtener las peliculas populares
    
    func testFetchMovies() {
        let worker = MoviesWorker(MoviesAPIRepository()) //Api porque el test debe ser independiente y es por esta razon que debe traerse las peliculas mas populares
        let promise = expectation(description: "200 OK")
        worker.fetchMovies { (result) in
            switch result {
            case .failure(let error):
                XCTFail(error.localizedDescription)
                break
            case .success(let movies):
                XCTAssert(movies.count > 0, "Movies could not fetched")
                promise.fulfill()
                break
            }
        }
        wait(for: [promise], timeout: 3.0)
    }
    
    //MARK: - 2do test: Buscar la pelicula "Wonder Woman"
    
    func testSearchWonderWoman() {
        let promise = expectation(description: "200 OK")
        searchMovie("wonder woman") { (result) in
            switch result {
            case .failure(let error):
                XCTFail(error.localizedDescription)
                break
            case .success(let movies):
                XCTAssert(movies.contains(where: { ($0.title!.lowercased().contains("wonder woman")) }), "no movie matched")
                promise.fulfill()
                break
            }
        }
        wait(for: [promise], timeout: 5.0)
    }
    
    //MARK: - 3er test: Buscar un titulo que no existe
    
    func testSearchWTFTitle() {
        let promise = expectation(description: "200 OK")
        searchMovie("dskadljsakldjksal") { (result) in
            switch result {
            case .failure(let error):
                XCTFail(error.localizedDescription)
                break
            case .success(let movies):
                XCTAssert(movies.count == 0, "Encontre peliculas")
                promise.fulfill()
                break
            }
        }
        wait(for: [promise], timeout: 5.0)
    }
    
    //MARK: - Search Movie
    
    private func searchMovie(_ text: String, _ assertion: @escaping (_ result: SearchPopularMoviesResult) -> Void) {
        let worker = MoviesWorker(MoviesCoreDataRepository()) //Core data porque es este repo que exigen en la tarea
        worker.searchMovies(text: text, assertion)
    }

}
