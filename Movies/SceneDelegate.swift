//
//  SceneDelegate.swift
//  Movies
//
//  Created by Pedro on 23-07-24.
//

import UIKit
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var mainCoordinator: MainCoordinator?
    var cancellables = Set<AnyCancellable>()

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions) {
            guard let scene = (scene as? UIWindowScene) else { return }
            window = UIWindow(windowScene: scene)

            /// Sorry about the boilerplate mate. Though about a @Injected property wrapper,
            /// but to keep the project as standard as possible went for manual injection.
            ///  Update: Really regretted  about manual approach
            let movieRemoteDataSource = MovieServiceApiImpl()
            let favoriteMovieLocalDataSource = FavoriteMovieLocalDataSourceImpl()
            let movieRepository = MovieRepositoryImpl(
                remoteDataSource: movieRemoteDataSource)
            let genreLocalDataSource = GenreLocalDataSourceImpl()
            let genreRepository = GenreRepositoryImpl(
                remoteDataSource: movieRemoteDataSource,
                localDataSource: genreLocalDataSource
            )
            let favoriteRepository = FavoriteRepositoryImpl(
                localDataSource: favoriteMovieLocalDataSource
            )
            #if UI_TEST
            let getMoviesUseCase = UITestGetMoviesUseCaseImpl()
            #else
            let getMoviesUseCase = GetMoviesUseCaseImpl(moviesRepository: movieRepository)
            #endif
            let getGenresByIdsUseCase = GetGenresByIdsUseCaseImpl(genreRepository: genreRepository)

            /// Another solution would be merge favorite operations in a FavoriteService,
            /// and then call the repository directly. But I already did write those usecases.
            /// so anyways it's better for abstraction.
            /// UPDATE: End it up moving all favorite operation to a separate repository
            let getFavoritesUseCase = GetFavoritesUseCaseImpl(
                favoriteRepository: favoriteRepository
            )
            let deleteFavoriteUseCase = DeleteFavoriteUseCaseImpl(
                favoriteRepository: favoriteRepository
            )
            let addFavoriteUseCase = AddFavoriteUseCaseImpl(
                favoriteRepository: favoriteRepository
            )
            let isFavoriteUseCase = IsFavoriteMovieUseCaseImpl(
                favoriteRepository: favoriteRepository
            )

            /// Bear with me, MoviesViewController and FavoritesViewController needs to
            /// handle their own navigation in order to use the navigation search bar.
            /// Thought about an intermediate VC to handle and pass the queries but it felt hacky.
            let moviesCoordinator = MoviesCoordinator(
                navigationController: UINavigationController(),
                getMoviesUseCase: getMoviesUseCase,
                getFavoritesUseCase: getFavoritesUseCase,
                deleteFavoriteUseCase: deleteFavoriteUseCase,
                getGenresByIdsUseCase: getGenresByIdsUseCase,
                addFavoriteUseCase: addFavoriteUseCase,
                isFavoriteUseCase: isFavoriteUseCase
            )

            let getGenresUseCase = GetGenresUseCaseImpl(
                genreRepository: genreRepository
            )
            let favoritesCoordinator = FavoritesCoordinator(
                navigationController: UINavigationController(),
                getFavoritesUseCase: getFavoritesUseCase,
                deleteFavoriteUseCase: deleteFavoriteUseCase,
                getGenresUseCase: getGenresUseCase,
                getGenresByIdsUseCase: getGenresByIdsUseCase,
                addFavoriteUseCase: addFavoriteUseCase,
                isFavoriteUseCase: isFavoriteUseCase
            )

            let navigationController = UINavigationController()
            mainCoordinator = MainCoordinator(
                navigationController: navigationController,
                moviesCoordinator: moviesCoordinator,
                favoritesCoordinator: favoritesCoordinator
            )
            mainCoordinator?.start()

            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()

            let syncGenresUseCase = SyncGenresUseCaseImpl(
                genreRepository: genreRepository
            )
            syncGenresUseCase
                    .execute()
                    .replaceError(with: false)
                    .sink {
                        print("Update genres from remote result: \($0)")
                    }.store(in: &cancellables)
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

}
