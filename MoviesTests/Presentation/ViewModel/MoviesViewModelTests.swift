//
//  MoviesViewModelTests.swift
//  MoviesTests
//
//  Created by Pedro on 27-07-24.
//

import XCTest
import Combine
@testable import Movies

final class MoviesViewModelTests: XCTestCase {
    var viewModel: MoviesViewModel!
    var mockGetMoviesUseCase: MockGetMoviesUseCase!
    var addFavoritesUseCase: AddFavoriteUseCase!
    var deleteFavoriteUseCase: DeleteFavoriteUseCase!
    var isFavoriteMovieUseCase: IsFavoriteMovieUseCase!
    var cancellables: Set<AnyCancellable>!

    override func setUp() async throws {
        try await super.setUp()
        await MainActor.run {
            mockGetMoviesUseCase = MockGetMoviesUseCase()
            addFavoritesUseCase = MockAddFavoriteUseCase()
            deleteFavoriteUseCase = MockDeleteFavoriteUseCase()
            isFavoriteMovieUseCase = MockIsFavoriteMovieUseCase()
            viewModel = MoviesViewModel(
                getMoviesUseCase: mockGetMoviesUseCase,
                addFavoriteUseCase: addFavoritesUseCase,
                deleteFavoriteUseCase: deleteFavoriteUseCase,
                isFavoriteMovieUseCase: isFavoriteMovieUseCase
            )
            cancellables = Set<AnyCancellable>()
        }
    }

    override func tearDown() {
        mockGetMoviesUseCase = nil
        viewModel = nil
        cancellables.forEach { $0.cancel() }
        cancellables = nil
        super.tearDown()
    }

    func testShowsSuccessUI() async throws {
        // Arrange
        let movies = MovieStub.movies
        mockGetMoviesUseCase.moviesStub = Just(movies)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()

        // Act
        let expectation = expectation(description: "Shows success UI")
        await MainActor.run {
            viewModel
                .$uiState
                .sink {
                    if case .success = $0 {
                        expectation.fulfill()
                    }
                }.store(in: &cancellables)
            viewModel.getMovies()
        }
        await fulfillment(of: [expectation], timeout: 1)

        // Assert
        await MainActor.run {
            XCTAssert(viewModel.uiState == .success)
            XCTAssertEqual(viewModel.filteredMovies, movies)
        }
    }

    func testShowsErrorUI() async throws {
        // Arrange
        mockGetMoviesUseCase.moviesStub = Fail(
            error: URLError(.notConnectedToInternet)
        ).eraseToAnyPublisher()

        // Act
        let expectation = expectation(description: "Shows error UI")
        await MainActor.run {
            viewModel
                .$uiState
                .sink {
                    if case .error = $0 {
                        expectation.fulfill()
                    }
                }.store(in: &cancellables)
            viewModel.getMovies()
        }
        await fulfillment(of: [expectation], timeout: 1)

        // Assert
        await MainActor.run {
            XCTAssert(viewModel.uiState == .error)
        }
    }

    class MockGetMoviesUseCase: GetMoviesUseCase {
        var moviesStub: AnyPublisher<[Movie], Error>!

        func execute(page: Int) -> AnyPublisher<[Movie], Error> {
            return moviesStub
        }
    }

    class MockAddFavoriteUseCase: AddFavoriteUseCase {
        func execute(movie: Movie) -> AnyPublisher<Void, Error> {
            fatalError()
        }
    }

    class MockDeleteFavoriteUseCase: DeleteFavoriteUseCase {
        func execute(movie: Movies.Movie) -> AnyPublisher<Void, Error> {
            fatalError()
        }
    }

    class MockIsFavoriteMovieUseCase: IsFavoriteMovieUseCase {
        func execute(movie: Movie) -> AnyPublisher<Bool, any Error> {
            fatalError()
        }
    }
}
