//
//  NetworkRequest.swift
//  TMDB Reloaded
//
//  Created by Miguel Duran on 1/4/19.
//  Copyright © 2018 Miguel Duran. All rights reserved.
//

import Foundation

protocol NetworkRequest: class {
    associatedtype ModelType
    var urlRequest: URLRequest { get }
    var session: URLSession { get }
    var task: URLSessionDataTask? { get set }
    func deserialize(_ data: Data?, response: HTTPURLResponse) throws -> ModelType
}

extension NetworkRequest {
    func execute(withCompletion completion: @escaping (Result<ModelType>) -> Void) {
        task = session.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            //            debugPrint(self?.urlRequest.allHTTPHeaderFields ?? [])
            debugPrint(self?.urlRequest.url?.absoluteURL ?? "")
            guard let strongSelf = self else {
                return
            }
            let result = Result { () throws -> ModelType in
                try error?.toNetworkError()
                guard let response = response as? HTTPURLResponse else {
                    throw NetworkError.unrecoverable
                }
                try response.validate()
                return try strongSelf.deserialize(data, response: response)
            }
            completion(result)
        }
        task?.resume()
    }
}

// MARK: - Validable
protocol Validable {
    func validate(_ response: HTTPURLResponse) throws
}

// MARK: - JSONDataRequest
protocol JSONDataRequest: Validable, NetworkRequest where ModelType: Decodable {}

extension JSONDataRequest {
    func deserialize(_ data: Data?, response: HTTPURLResponse) throws -> ModelType {
        guard let data = data else {
            throw NetworkError.unrecoverable
        }
        try validate(response)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
        do {
            return try decoder.decode(ModelType.self, from: data) }
        catch {
            debugPrint(error)
            throw NetworkError.unrecoverable
        }
    }
}
