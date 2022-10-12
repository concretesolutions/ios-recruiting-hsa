//
//  Api.swift
//
//
//  Created by Jonathan Pacheco on 11/10/22.
//

import Foundation
import Combine
import Injection
import Extensions

public protocol ConnectionInterface {
    
    func connect<T>(endpoint: T) -> AnyPublisher<Data, Error> where T: Endpoint
    func connect<T>(endpoint: T) async throws -> Data where T: Endpoint
}

public enum Api {
    
    public static func register() {
        Container.default.register(type: ConnectionInterface.self, value: ApiConnection())
    }
}

struct ApiConnection: ConnectionInterface {
    
    enum ConnectError: String, Swift.Error {
        case invalidUrl, mappingError, unknown
    }
    
    private func request<T>(for endpoint: T) throws -> URLRequest where T: Endpoint {
        guard let url = Encoding.requestUrl(for: endpoint) else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = addDefaultHeaders(headers: endpoint.headers)
        if !endpoint.params.isEmpty && endpoint.method != .get {
            request.httpBody = Encoding.httpBody(params: endpoint.params)
        }
        return request
    }
    
    func connect<T>(endpoint: T) -> AnyPublisher<Data, Error> where T: Endpoint {
        do {
            let sessionConfiguration = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfiguration)
            let request = try request(for: endpoint)
            return session.dataTaskPublisher(for: request)
                .map { (value: (data: Data, response: URLResponse)) -> Data in
                    value.data
                }
                .mapError { $0 }
                .eraseToAnyPublisher()
        } catch let error {
            return .error(error)
        }
    }
    
    func connect<T>(endpoint: T) async throws -> Data where T : Endpoint {
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration)
        let request = try request(for: endpoint)
        let response = try await session.data(for: request)
        return response.0
    }
    
    
    private func addDefaultHeaders(headers: [String: String]) -> [String: String] {
        //var headers = headers
        /**
         Add headers here por example:
         `headers["public-api-key"] = key`
         */
        return headers
    }
}

enum Encoding {
    
    static func httpBody(params: [String: Any]) -> Data? {
        try? JSONSerialization.data(withJSONObject: params)
    }
    
    static func requestUrl<T: Endpoint>(for endpoint: T) -> URL? {
        @Inject var environment: Envirotment?
    
        let version = environment?.apiVersion ?? ""
        
        var components = URLComponents()
        components.scheme = environment?.scheme
        components.host = environment?.baseUrl
        components.port = environment?.port
        components.path = version + endpoint.path
        components.queryItems = [URLQueryItem(name: "api_key", value: "851097f424bd6f189ec219b33b729a2d")]
        if endpoint.method == .get && !endpoint.params.isEmpty {
            let items = endpoint.params.map { (key: String, value: Any) -> URLQueryItem in
                URLQueryItem(name: key, value: String(describing: value))
            }
            components.queryItems?.append(contentsOf: items)
        }
        return components.url
    }
}
