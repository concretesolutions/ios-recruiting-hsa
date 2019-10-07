//
//  HomeMovieServices.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/2/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

enum HomeMovieEndpoints: String{
    case popular  = "movie/popular"
    case search   = "search/movie"
}

enum MovieListParameterKeys: String{
    case page = "page"
    case query = "query"
}

enum HomeMovieServices: ServiceRequest{
    
    case popular(page: Int)
    case search(query: String, page: Int)
    
    var path: String{
        switch self {
        case .popular(_):
            return HomeMovieEndpoints.popular.rawValue
        case .search(_):
            return HomeMovieEndpoints.search.rawValue
        }
    }
    
    var method: HTTPMethods{
        switch self {
        case .popular(_), .search(_):
            return .get
        }
    }
    
    var headers: [String : String]?{
        return ["Content-Type":"application/json",
                "Accept": "application/json"]
    }
    
    var bodyParams: [String : Any]?{
        return nil
    }
    
    var urlQueryParams: [String : Any]?{
        switch self {
        case .popular(let page):
            return [QueryApiKey.api_key.rawValue : ExternalApiKeys.moviedb.rawValue,
                    MovieListParameterKeys.page.rawValue: String(page)]
        case .search(let query, page: let page):
            return [QueryApiKey.api_key.rawValue: ExternalApiKeys.moviedb.rawValue,
                    MovieListParameterKeys.page.rawValue: String(page),
                    MovieListParameterKeys.query.rawValue: query]
        }
    }
    
}
