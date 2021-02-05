//
//  NetworkingUtil.swift
//  Movies
//
//  Created by Alfredo Luco on 05-02-21.
//

import Foundation

enum ManagedURLRequest {
    
    //MARK: - Endpoints
    
    case fetchMovies(_ params: [String : Any])
    case fetchMovie(_ id: Int32, _ params: [String : Any])
    case fetchCategories(_ params: [String : Any])
    
    //MARK: - Base URL
    
    var baseURL: String {
        Constants.baseURL
    }
    
    //MARK: - Methods
    
    var method: String {
        switch self {
        case .fetchMovies(_):
            return "GET"
        case .fetchMovie:
            return "GET"
        case .fetchCategories:
            return "GET"
        }
    }
    
    
    //MARK: - Paths
    
    var path: String {
        switch self {
        case .fetchMovies:
            return "/movie/popular"
        case .fetchMovie(let id,_):
            return "/movie/\(id)"
        case .fetchCategories:
            return "/genre/movie/list"
        }
    }
    
    //MARK: - As URLRequest
    
    func asURLRequest() throws -> URLRequest {
        guard var urlComponents = URLComponents(string: self.baseURL + self.path) else {
            throw NSError(domain: "Movies", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }
        var queryItems: [URLQueryItem] = [URLQueryItem(name: "api_key", value: Constants.apiKey)]
        
        
        func setParams(_ params: [String : Any], _ queryItems: inout [URLQueryItem]) {
            for key in params.keys {
                queryItems.append(URLQueryItem(name: key, value: params[key] as? String))
            }
        }
        
        switch self {
        case .fetchMovies(let params):
            setParams(params, &queryItems)
            break
        case .fetchMovie(_, let params):
            setParams(params, &queryItems)
            break
        case .fetchCategories(let params):
            setParams(params, &queryItems)
            break
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            throw NSError(domain: "Movies", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])

        }
        
        return URLRequest(url: url)
    }
}
