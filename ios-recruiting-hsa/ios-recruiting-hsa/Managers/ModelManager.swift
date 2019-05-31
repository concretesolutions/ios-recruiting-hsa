//
//  ModelManager.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/30/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation

enum ModelManagerError: Error {
    case unableToFetchMovies(Error)
    case unableToFetchGenres(Error)
}

typealias Page = Int

protocol ModelManager {
    func getPaginatedMovies(
        forPage: Int,
        onSuccess: ((Page, [PopularMovie]) -> Void)?,
        onError: ((ModelManagerError) -> Void)?
    )

    func getGenres(onSuccess: (([Genre]) -> Void)?, onError: ((ModelManagerError) -> Void)?)
}

func modelManagerDefault() -> ModelManager {
    return ModelManagerImpl(movieClient: movieClientDefault(), persitance: persistanceDefault())
}

// Implementation

private enum ApiKeys {
    static let favoriteMovieFormat = "MovieId_%@"
}

class ModelManagerImpl {

    let movieClient: MovieClient
    let persitance: Persistance

    init(movieClient: MovieClient, persitance: Persistance) {
        self.movieClient = movieClient
        self.persitance = persitance
    }
}

extension ModelManagerImpl: ModelManager {

    func getPaginatedMovies(
        forPage page: Int,
        onSuccess: ((Page, [PopularMovie]) -> Void)?,
        onError: ((ModelManagerError) -> Void)?
    ) {
        movieClient.popularMovies(
            forPage: page,
            onSuccess: { moviesResponse in
                onSuccess?(moviesResponse.page, moviesResponse.results)
            },
            onError: { errorData in
                onError?(.unableToFetchMovies(errorData))
            }
        )
    }

    func getGenres(onSuccess: (([Genre]) -> Void)?, onError: ((ModelManagerError) -> Void)?) {
        movieClient.genres(
            onSuccess: { genresResponse in
                onSuccess?(genresResponse.genres)
            },
            onError: { errorData in
                onError?(.unableToFetchGenres(errorData))
            }
        )
    }
}
