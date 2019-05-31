//
//  MovieClient.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/29/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation

enum MovieClientError: Error {
    case decoded(description: String)
    case underlying(error: Error)
    case apiError(error: ApiError)
}

protocol MovieClient {
    func popularMovies(
        forPage: Int,
        onSuccess: ((PopularMoviesApiRepsonse) -> Void)?,
        onError: ((MovieClientError) -> Void)?
    )
    func genres(onSuccess: ((GenreApiResponse) -> Void)?, onError: ((MovieClientError) -> Void)?)
}

func movieClientDefault() -> MovieClient {
    return MovieClientImpl(apiClient: apiClientDefault())
}

// MARK: - Implementation

class MovieClientImpl {

    let apiClient: ApiClient

    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
}

extension MovieClientImpl: MovieClient {

    func popularMovies(
        forPage page: Int,
        onSuccess: ((PopularMoviesApiRepsonse) -> Void)? = nil,
        onError: ((MovieClientError) -> Void)? = nil
    ) {
        apiClient.request(endpoint: .popular(page: page)) { [weak self] data, error in
            self?.decode(
                for: PopularMoviesApiRepsonse.self,
                withData: data,
                onSuccess: onSuccess,
                withError: error,
                onError: onError
            )
        }
    }

    func genres(
        onSuccess: ((GenreApiResponse) -> Void)? = nil,
        onError: ((MovieClientError) -> Void)? = nil
    ) {
        apiClient.request(endpoint: .genres) { [weak self] data, error in
            self?.decode(
                for: GenreApiResponse.self,
                withData: data,
                onSuccess: onSuccess,
                withError: error,
                onError: onError
            )
        }
    }

    private func decode<T: Decodable>(
        for type: T.Type,
        withData data: Data?,
        onSuccess: ((T) -> Void)?,
        withError error: ApiError?,
        onError: ((MovieClientError) -> Void)?
    ) {
        if let data = data {
            do {
                let movies = try JSONDecoder().decode(type, from: data)
                onSuccess?(movies)
            } catch DecodingError.dataCorrupted(let context) {
                onError?(.decoded(description: context.debugDescription))
            } catch {
                onError?(.underlying(error: error))
            }
        } else if let error = error {
            onError?(.apiError(error: error))
        }
    }
}
