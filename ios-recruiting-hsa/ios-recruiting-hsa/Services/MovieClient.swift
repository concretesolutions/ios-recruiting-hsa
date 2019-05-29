//
//  MovieClient.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/29/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation

enum MovieClientError {
    case decoded(description: String)
    case underlying(error: Error)
    case apiError(error: ApiError)
}

protocol MovieClient {
    func popularMovies(
        forPage: Int,
        onSuccess: (([PopularMovie]) -> Void)?,
        onError: ((MovieClientError) -> Void)?
    )
    func genres(onSuccess: (([Genre]) -> Void)?, onError: ((MovieClientError) -> Void)?)
}

// MARK: - Implementation

class MovieClientImp {

    let apiClient: ApiClient

    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
}

extension MovieClientImp: MovieClient {

    func popularMovies(
        forPage page: Int,
        onSuccess: (([PopularMovie]) -> Void)? = nil,
        onError: ((MovieClientError) -> Void)? = nil
    ) {
        apiClient.request(endpoint: .popular(page: page)) { [weak self] data, error in
            self?.decode(
                for: [PopularMovie].self,
                withData: data,
                onSuccess: onSuccess,
                withError: error,
                onError: onError
            )
        }
    }

    func genres(
        onSuccess: (([Genre]) -> Void)? = nil,
        onError: ((MovieClientError) -> Void)? = nil
    ) {
        apiClient.request(endpoint: .genres) { [weak self] data, error in
            self?.decode(
                for: [Genre].self,
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
