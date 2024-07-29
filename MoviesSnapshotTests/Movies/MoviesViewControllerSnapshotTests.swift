//
//  MoviesViewControllerSnapshotTests.swift
//  MoviesSnapshotTests
//
//  Created by Pedro on 28-07-24.
//

import Foundation
import iOSSnapshotTestCase
import Combine
@testable import Movies

final class MoviesViewControllerSnapshotTests: FBSnapshotTestCase {
    var viewController: MoviesViewController!
    var viewModel: MoviesViewModel!
    var coordinator: MoviesCoordinator!

    override func setUp() {
        super.setUp()
        recordMode = false
    }

    override func setUp() async throws {
        try await super.setUp()

        await MainActor.run {
            /// Regretted about no creating a protocol for MoviesViewModel and MoviesCoordinator
            viewModel = MoviesViewModel(
                getMoviesUseCase: MockGetMoviesUseCase(),
                addFavoriteUseCase: MockAddFavoriteUseCase(),
                deleteFavoriteUseCase: MockDeleteFavoriteUseCase(),
                isFavoriteMovieUseCase: MockIsFavoriteMovieUseCase()
            )
            coordinator = MoviesCoordinator(
                navigationController: UINavigationController(),
                getMoviesUseCase: UITestGetMoviesUseCaseImpl(),
                getFavoritesUseCase: MockGetFavoritesUseCase(),
                deleteFavoriteUseCase: MockDeleteFavoriteUseCase(),
                getGenresByIdsUseCase: MockGetGenresByIdsUseCase(),
                addFavoriteUseCase: MockAddFavoriteUseCase(),
                isFavoriteUseCase: MockIsFavoriteMovieUseCase()
            )
            /// Here I should be injecting just mocks for viewModel and coordinator 🙃
            viewController = MoviesViewController(
                viewModel: viewModel,
                moviesCoordinator: coordinator
            )
            viewController.loadViewIfNeeded()
        }
    }

    func testLoadingState() async {
        await MainActor.run {
            // Arrange
            viewController.view.frame = UIScreen.main.bounds

            // Act
            viewModel.uiState = .loading

            // Assert
            FBSnapshotVerifyView(viewController.view)
        }
    }

    func testSuccessState() async {
        await MainActor.run {
            // Arrange
            viewController.view.frame = UIScreen.main.bounds

            // Act
            viewModel.uiState = .success
            viewModel.filteredMovies = MovieStub.movies
        }

        await MainActor.run {
            // Assert
            FBSnapshotVerifyView(viewController.view)
        }
    }

    func testSuccessError() async {
        await MainActor.run {
            // Arrange
            viewController.view.frame = UIScreen.main.bounds

            // Act
            viewModel.uiState = .error
        }

        await MainActor.run {
            // Assert
            FBSnapshotVerifyView(viewController.view)
        }
    }

    override func tearDown() {
        viewController = nil
        viewModel = nil
        coordinator = nil
        super.tearDown()
    }

    class MockGetMoviesUseCase: GetMoviesUseCase {
        func execute(page: Int) -> AnyPublisher<[Movie], Error> {
            Just([])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }

    class MockIsFavoriteMovieUseCase: IsFavoriteMovieUseCase {
        func execute(movie: Movie) -> AnyPublisher<Bool, Error> {
            Just(false)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
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

    class MockGetFavoritesUseCase: GetFavoritesUseCase {
        func execute() -> AnyPublisher<[Movie], any Error> {
            fatalError()
        }
    }

    class MockGetGenresByIdsUseCase: GetGenresByIdsUseCase {
        func execute(ids: [Int]) -> AnyPublisher<[Genre], any Error> {
            fatalError()
        }
    }
}
