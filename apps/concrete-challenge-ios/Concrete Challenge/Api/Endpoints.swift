//
//  Endpoints.swift
//  Concrete Challenge
//
//  Created by Jonathan Pacheco on 11/10/22.
//

import Foundation
import Api

enum Endpoints {
    
    struct GetPopularMovies: Endpoint {
        
        struct Response: Decodable {
            let page: Int
            let results: [Movie]
            let totalPages: Int
            let totalResults: Int
        }
                
        var path: String { "/movie/popular" }
        var method: EndpointMethod { .get }
    }
    
    struct GetMoviesGenres: Endpoint {
        
        var path: String { "/genre/movie/list" }
        var method: EndpointMethod { .get }
        
        struct Response: Decodable {
            let genres: [Genre]
        }
    }
}
