//
//  RemoteAPIRouter.swift
//  MovieApp
//
//  Created by Sebastian Diaz on 4/4/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import Foundation
import Alamofire


enum RemoteAPIRouter : URLRequestConvertible {
    
    case getPopularMovies(_ page: Int)
    case getDetailMovie(_ id: Int)
    case getGenre
    
    
    var method : HTTPMethod {
        switch self {
        case .getPopularMovies, .getDetailMovie,.getGenre:
            return .get
        }
    }
    
    var path : String {
        switch self {
        case.getPopularMovies:
            return "popular"
        case let .getDetailMovie(id):
            return "movie/"+String(id)
        case .getGenre:
            return "list"
        }
    }
    
    var headers : HTTPHeaders{
        switch self {
        case .getPopularMovies,.getDetailMovie,.getGenre:
            return ["Content-Type":"application/x-www-form-urlencoded"]
        }
    }
    

    var params : [String:Any] {
        var paramDict : [String:Any] = [:]
        switch self {
        case .getPopularMovies,.getDetailMovie,.getGenre:
            paramDict["api_key"] = "6893e0b3a6030f46d850edf87283de46"
            return paramDict
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let urlComponent = URLComponents(string: "https://api.themoviedb.org/3/movie/")!
        var urlRequest = URLRequest(url:urlComponent.url!.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        
        return try URLEncoding.methodDependent.encode(urlRequest, with: params)
    }
    
}




