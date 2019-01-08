//
//  ApiRequest.swift
//  TMDB Reloaded
//
//  Created by Miguel Duran on 1/4/19.
//  Copyright © 2018 Miguel Duran. All rights reserved.
//

import Foundation

protocol APIRequest: NetworkRequest {
    var url: URL { get }
}

extension APIRequest {
    var apiKeyURLRequest: URLRequest {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = [URLQueryItem]()
        let queryItem = URLQueryItem(name: TMDBEndpoint.Field.apiKey.value, value: TMDBEndpoint.apiKey)
        urlComponents.queryItems?.append(queryItem)
        let request = URLRequest(url: urlComponents.url!)
        return request
    }
    
    func validate(_ response: HTTPURLResponse) throws {
        if response.statusCode == 401 {
            throw NetworkError.unauthorized
        }
    }
}

// MARK: - ListRequest
class ListRequest<ModelType: Decodable>: APIRequest, JSONDataRequest {
    let url: URL
    let page: Int
    var task: URLSessionDataTask?
    let session: URLSession
    
    init(url: URL, session: URLSession, page: Int = 1) {
        self.url = url
        self.session = session
        self.page = page
    }
}

extension ListRequest: NetworkRequest {
    var urlRequest: URLRequest {
        var request = apiKeyURLRequest
        var urlComponents = URLComponents(url: request.url!, resolvingAgainstBaseURL: true)!
        let queryItem = URLQueryItem(name: TMDBEndpoint.Field.page.value, value: "\(page)")
        urlComponents.queryItems?.append(queryItem)
        request.url = urlComponents.url!
        return request
    }

}

// MARK: - FetchRequest
class FetchRequest<ModelType: Decodable>: APIRequest, JSONDataRequest {
    let url: URL
    var task: URLSessionDataTask?
    let session: URLSession
    
    init(url: URL, session: URLSession, page: Int = 1) {
        self.url = url
        self.session = session
    }
}

extension FetchRequest: NetworkRequest {
    var urlRequest: URLRequest {
        let request = apiKeyURLRequest
        return request
    }
}
