//
//  MovieServiceApiImplTests.swift
//  MoviesTests
//
//  Created by Pedro on 27-07-24.
//

import XCTest
import Combine
@testable import Movies

final class MovieServiceApiImplTests: XCTestCase {
    // Do you guys prefer 'sut'?
    var movieServiceApiImpl: MovieServiceApiImpl!
    var mockSession: MockURLSession!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        movieServiceApiImpl = MovieServiceApiImpl(session: mockSession!)
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        mockSession = nil
        movieServiceApiImpl = nil
        cancellables.forEach { $0.cancel() }
        cancellables = nil
        super.tearDown()
    }

    // Do you guys prefer 'GWT'?
    func testMoviesDataSuccess() throws {
        // Arrange
        let data = try Data(contentsOf: MovieStub.jsonResponseUrl)
        mockSession.data = data

        // Act
        var receivedMovies: [Movie]?
        var receivedError: Error?
        let expectation = expectation(description: "Service parses json response into movies successfully")
        movieServiceApiImpl
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

        // Assert
        XCTAssertNotNil(receivedMovies)
        XCTAssertNil(receivedError)
    }

    func testMoviesDataParseFailure() throws {
        // Arrange
        let data = try Data(contentsOf: MovieStub.jsonBadResponseUrl)
        mockSession.data = data

        // Act
        var receivedMovies: [Movie]?
        var receivedError: Error?
        let expectation = expectation(
            description: "Service fails to parse a bad json response"
        )
        movieServiceApiImpl
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

        // Assert
        XCTAssertNil(receivedMovies)
        XCTAssertNotNil(receivedError)
    }

    func testGenresDataSuccess() throws {
        // Arrange
        let data = try Data(contentsOf: GenreStub.jsonResponseUrl)
        mockSession.data = data

        // Act
        var receivedGenres: [Genre]?
        var receivedError: Error?
        let expectation = expectation(
            description: "Service parses json response into genres successfully"
        )
        movieServiceApiImpl
            .fetchGenres()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let failure):
                    receivedError = failure
                    expectation.fulfill()
                }
            }, receiveValue: {
                receivedGenres = $0
            }).store(in: &cancellables)
        waitForExpectations(timeout: 1)

        // Assert
        XCTAssertNotNil(receivedGenres)
        XCTAssertNil(receivedError)
    }

    func testNetworkError() throws {
        // Arrange
        mockSession.error = URLError(.networkConnectionLost)

        // Act
        var receivedMovies: [Movie]?
        var receivedError: Error?
        let expectation = expectation(description: "Service fails due network error")
        movieServiceApiImpl
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

        // Assert
        XCTAssertNil(receivedMovies)
        XCTAssertNotNil(receivedError)
    }
}

struct URLSessionStub {
    static let url = URL(string: "https://domain.com")!
}

class MockURLSession: URLSessionProtocol {
    var data: Data?
    var error: URLError?

    func dataTaskPublisher(request: URLRequest) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        if let data {
            let response = URLResponse(
                url: request.url!,
                mimeType: nil,
                expectedContentLength: data.count,
                textEncodingName: nil
            )
            return Just((data, response))
                .setFailureType(to: URLError.self)
                .eraseToAnyPublisher()
        } else if let error {
            return Fail(error: error).eraseToAnyPublisher()
        } else {
            return Fail(error: URLError(.unknown)).eraseToAnyPublisher()
        }
    }
}

protocol TestBundle: AnyObject { }
extension TestBundle {
    static var bundle: Bundle {
        return Bundle(for: Self.self)
    }
}
class MovieStub: TestBundle {
    class var jsonResponseUrl: URL {
        return bundle.url(
            forResource: "MockMovieResponse",
            withExtension: "json"
        )!
    }
    class var jsonBadResponseUrl: URL {
        return bundle.url(
            forResource: "MockBadMovieResponse",
            withExtension: "json"
        )!
    }
    class var movies: [Movie] {
        let data = try! Data(contentsOf: jsonResponseUrl)
        return try! JSONDecoder().decode(MovieResponse.self, from: data).results
    }
}

class GenreStub: TestBundle {
    class var jsonResponseUrl: URL {
        return bundle.url(
            forResource: "MockGenreResponse",
            withExtension: "json"
        )!
    }
    class var genres: [Genre] {
        let data = try! Data(contentsOf: jsonResponseUrl)
        return try! JSONDecoder().decode(GenreResponse.self, from: data).genres
    }
}
