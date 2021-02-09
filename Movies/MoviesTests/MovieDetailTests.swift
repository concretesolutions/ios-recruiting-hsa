//
//  MovieDetailTests.swift
//  MoviesTests
//
//  Created by Alfredo Luco on 09-02-21.
//

import XCTest
@testable import Movies

class MovieDetailTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    //MARK: - 1er test: Agregar una pelicula a favoritos
    
    func testStarMovie() {
        let promise = expectation(description: "200 OK")
        getMovie(464052) { (result) in
            switch result {
            case .failure(let error):
                XCTFail(error.localizedDescription)
                break
            case .success(let movie):
                let flag = movie.starred
                let worker = MoviesWorker(MoviesCoreDataRepository())
                worker.starMovie(id: movie.id) { (starResult) in
                    switch starResult {
                    case .failure(let error):
                        XCTFail(error.localizedDescription)
                        break
                    case .success(_):
                        self.getMovie(movie.id) { (fetchResult) in
                            switch fetchResult {
                            case .failure(let error):
                                XCTFail(error.localizedDescription)
                                break
                            case .success(let movie2):
                                XCTAssert(movie2.starred != flag, "No se ha mutado el valor de favoritos")
                                promise.fulfill()
                                break
                            }
                        }
                        break
                    }
                }
            }
        }
        wait(for: [promise], timeout: 5.0)
    }
    
    func getMovie(_ id: Int32, _ result: @escaping FetchMovieCompletion) {
        let worker = MovieDetailWorker(repo: CategoriesAPIRepository(), repo: MoviesCoreDataRepository())
        worker.fetchMovie(by: id, completion: result)
    }

}
