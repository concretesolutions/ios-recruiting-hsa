//
//  Endpoint.swift
//  TMDB Reloaded
//
//  Created by Miguel Duran on 1/4/19.
//  Copyright © 2018 Miguel Duran. All rights reserved.
//

import Foundation

class TMDBEndpoint {
    
    static let apiKey = "9573a954d878b8c686236be7b7c653bd"
    static let apiRootURL = URL(string: "https://api.themoviedb.org/3")!
    
    static var popularMoviesURL: URL {
        return apiRootURL
            .appendPath(.movie)
            .appendPath(.popular)
    }
}

extension TMDBEndpoint {
    enum Path: String {
        case movie
        case popular
    }
    
    enum Field: String {
        case apiKey = "api_key"
        case language
        case page
        case region
        
        var value: String {
            return self.rawValue
        }
    }
}

extension URL {
    func appendPath(_ path: TMDBEndpoint.Path) -> URL {
        return appendingPathComponent(path.rawValue)
    }
}
