//
//  APIClient.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/27/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation

enum Endpoint {
    case popular(page: Int)
    case genres
}

extension Endpoint {

    var host: String { return "https://api.themoviedb.org" }

    var method: String { return "GET" }

    var parameters: [String: Any]? { return nil }

    var path: String {
        let commonPath = "/3/"
        let customPath: String
        switch self {
        case .popular: customPath = "movie/popular"
        case .genres: customPath = "genre/movie/list"
        }
        return "\(commonPath)\(customPath)"
    }
}

enum MovieDBError {
    case urlError(host: String, path: String)
}

typealias Callback = (Data?, MovieDBError?) -> Void

protocol ApiMovieDB {
    func request(endpoint: Endpoint, callback: Callback)
}

func apiMovieDBDefault() -> ApiMovieDB {
    return ApiMovieImpl(lang: "en-US", apiKey: Constants.apiKey, session: URLSession.shared)
}

// MARK: - Implementation

class ApiMovieImpl: ApiMovieDB {

    private let session: URLSession
    private let lang: String
    private let apiKey: String

    init(lang: String, apiKey: String, session: URLSession) {
        self.lang = lang
        self.apiKey = apiKey
        self.session = session
    }
}

extension ApiMovieImpl {

    func request(endpoint: Endpoint, callback: Callback) {
        var urlComponents = URLComponents()

        let host = endpoint.host
        urlComponents.host = host

        let path = endpoint.path
        urlComponents.path = path

        guard let url = urlComponents.url else {
            callback(nil, .urlError(host: host, path: path))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method

    }
}
