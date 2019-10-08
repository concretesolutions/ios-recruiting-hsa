//
//  HomeRouter.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/2/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import Alamofire

//String de los enpoints
enum HomeEndpoints: String{
    case popular  = "movie/popular"
    case topRated = "movie/top_rated"
    case upcoming = "movie/upcoming"
    case search   = "search/movie"
}

//Definicion del router
enum HomeRouter{
    case popular(page: Int)
    case topRated(page:Int)
    case upcoming(page:Int)
    case search(query: String, page: Int)
}

extension HomeRouter: ServiceRouter{
    
    var method: HTTPMethod {
        switch self {
        case .popular(_), .topRated(_), .upcoming(_), .search(_):
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .popular(_):
            return HomeEndpoints.popular.rawValue
        case .topRated(_):
            return HomeEndpoints.topRated.rawValue
        case .upcoming(_):
            return HomeEndpoints.upcoming.rawValue
        case .search(_):
            return HomeEndpoints.search.rawValue
        }
    }
    
    var bodyParameters: Parameters? {
        switch self {
        case .popular(_), .topRated(_), .upcoming(_), .search(_):
            return nil
        }
    }
    
    var queryItems: [URLQueryItem]?{
        switch self {
        case .popular(let page), .topRated(let page), .upcoming(page: let page):
            return [URLQueryItem.init(name: QueryApiKey.api_key.rawValue , value: ExternalApiKeys.moviedb.rawValue),
                    URLQueryItem.init(name: MovieListParameterKeys.page.rawValue, value: String(page))]
        case .search(let query, page: let page):
            return [URLQueryItem.init(name: QueryApiKey.api_key.rawValue , value: ExternalApiKeys.moviedb.rawValue),
                    URLQueryItem.init(name: MovieListParameterKeys.page.rawValue, value: String(page)),
                    URLQueryItem.init(name: MovieListParameterKeys.query.rawValue, value: query)]
        }
    }
    
}
