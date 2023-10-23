//
//  APIManager.swift
//  movieAppAccen
//
//  Created by Orlando Velasco on 20-10-23.
//

import Foundation

class APIManager {
    
    private let baseURL = "https://api.themoviedb.org/3"
    private var apiKey: String? {
        return KeychainManager.shared.get(key: KeychainKeys.apiKey)
    }
    
    func get(endpoint: String, parameters: [String: String] = [:], headers: [String: String] = [:], completion: @escaping (Data?, Error?) -> Void) {
        request(method: "GET", endpoint: endpoint, parameters: parameters, body: nil, headers: headers, completion: completion)
    }
    
    func post(endpoint: String, parameters: [String: String] = [:], body: Data?, headers: [String: String] = [:], completion: @escaping (Data?, Error?) -> Void) {
        request(method: "POST", endpoint: endpoint, parameters: parameters, body: body, headers: headers, completion: completion)
    }
    
    func delete(endpoint: String, parameters: [String: String] = [:], headers: [String: String] = [:], completion: @escaping (Data?, Error?) -> Void) {
        request(method: "DELETE", endpoint: endpoint, parameters: parameters, body: nil, headers: headers, completion: completion)
    }
    
    private func request(method: String, endpoint: String, parameters: [String: String], body: Data?, headers: [String: String], completion: @escaping (Data?, Error?) -> Void) {
        var urlComponents = URLComponents(string: baseURL + endpoint)
        
        let queryItems: [URLQueryItem] = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else {
            completion(nil, NSError(domain: "", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        if let apiKey = apiKey {
            request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        }
        
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        if let body = body {
            request.httpBody = body
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            completion(data, error)
        }
        
        task.resume()
    }
}
