//
//  MovieRepositoryImplTests.swift
//  MoviesTests
//
//  Created by Pedro on 27-07-24.
//

import XCTest
import Combine
@testable import Movies

final class MovieRepositoryImplTests: XCTestCase {
    var movieRepository: MovieRepositoryImpl!
    var mockRemoteDataSource: MockMovieServiceApi!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockRemoteDataSource = MockMovieServiceApi()
        movieRepository = MovieRepositoryImpl(remoteDataSource: mockRemoteDataSource)
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        mockRemoteDataSource = nil
        movieRepository = nil
        cancellables.forEach { $0.cancel() }
        cancellables = nil
        super.tearDown()
    }

    func testReturnMoviesSuccessfully() throws {
        // Arrange
        let movies = MovieStub.movies
        mockRemoteDataSource.movieStub = Just(movies)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()

        // Act
        var receivedMovies: [Movie]?
        var receivedError: Error?
        let expectation = expectation(
            description: "Repository returns movies from data source successfully"
        )
        movieRepository
            .fetchMovies(page: 1)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let failure):
                    receivedError = failure
                    expectation.fulfill()
                }
            }, receiveValue: {
                receivedMovies = $0
            }).store(in: &cancellables)
        waitForExpectations(timeout: 1)

        //Assert
        XCTAssertNil(receivedError)
        XCTAssertNotNil(receivedMovies)
        XCTAssertEqual(movies, receivedMovies)
    }

    func testReturnMoviesFails() throws {
        // Arrange
        let movies = MovieStub.movies
        mockRemoteDataSource.movieStub = Fail(error: MovieServiceError.badUrl)
            .eraseToAnyPublisher()

        // Act
        var receivedMovies: [Movie]?
        var receivedError: Error?
        let expectation = expectation(
            description: "Repository fails to get movies from data source"
        )
        movieRepository
            .fetchMovies(page: 1)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let failure):
                    receivedError = failure
                    expectation.fulfill()
                }
            }, receiveValue: {
                receivedMovies = $0
            }).store(in: &cancellables)
        waitForExpectations(timeout: 1)

        //Assert
        XCTAssertNotNil(receivedError)
        XCTAssertNil(receivedMovies)
    }
}

class MockMovieServiceApi: MovieServiceApi {
    var movieStub: AnyPublisher<[Movie], Error>!
    var genreStub: AnyPublisher<[Genre], Error>!

    func fetchMovies(page: Int) -> AnyPublisher<[Movie], Error> {
        return movieStub
    }

    func fetchGenres() -> AnyPublisher<[Genre], Error> {
        return genreStub
    }
}
