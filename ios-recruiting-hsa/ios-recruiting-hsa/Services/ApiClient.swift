//
//  APIClient.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/27/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation
import Moya

enum MovieEndpoint {
    case popular(page: Int)
    case genres
}

enum ApiError {
    case error(description: String?)
}

typealias Callback = (Data?, ApiError?) -> Void

protocol ApiClient {
    func request(endpoint: MovieEndpoint, callback: @escaping Callback)
}

// MARK: - Implementation

extension MovieEndpoint: TargetType {

    var baseURL: URL { return URL(string: "https://api.themoviedb.org" )! }

    var path: String {
        let commonPath = "/3/"
        let customPath: String
        switch self {
        case .popular: customPath = "movie/popular"
        case .genres: customPath = "genre/movie/list"
        }
        return "\(commonPath)\(customPath)"
    }

    var method: Moya.Method { return .get }

    var sampleData: Data { return Data() }

    var task: Task { return .requestPlain }

    var headers: [String: String]? { return nil }
}

extension ApiClient {

    var `default`: ApiClient {
        let endpointClosure = { (target: MovieEndpoint) -> Endpoint in
            var headers = target.headers
            headers?["lang"] = "en-US"
            headers?["api_key"] = Constants.apiKey
            return Endpoint(
                url: URL(target: target).absoluteString,
                sampleResponseClosure: {.networkResponse(200, target.sampleData)},
                method: target.method,
                task: target.task,
                httpHeaderFields: headers
            )
        }
        let provider = MoyaProvider<MovieEndpoint>(endpointClosure: endpointClosure)
        return ApiClientImpl(provider: provider)
    }
}

class ApiClientImpl {

    let provider: MoyaProvider<MovieEndpoint>

    init(provider: MoyaProvider<MovieEndpoint>) {
        self.provider = provider
    }
}

extension ApiClientImpl: ApiClient {

    func request(endpoint: MovieEndpoint, callback: @escaping Callback) {
        provider.request(endpoint) { result in
            switch result {
            case .success(let response):
                callback(response.data, nil)
            case .failure(let error):
                callback(nil, .error(description: error.errorDescription))
            }
        }
    }
}
