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
    
    case getPopularMovies(page : Int)
    
    
    var method : HTTPMethod {
        switch self {
        case .getPopularMovies:
            return .get
        }
    }
    
    var path : String {
        switch self {
        case.getPopularMovies:
            return "popular"
        }
    }
    
    
//    var query : [String:String] {
//        switch self {
//        case let .getPopularMovies(page):
//            return ["api_key":"6893e0b3a6030f46d850edf87283de46","page":String(page)]
//        }
//    }
    
    var headers : HTTPHeaders{
        switch self {
        case .getPopularMovies:
            return ["Content-Type":"application/x-www-form-urlencoded"]
        }
        
    }
    

    var params : [String:Any] {
        var paramDict : [String:Any] = [:]
        switch self {
        case .getPopularMovies:
            paramDict["api_key"] = "6893e0b3a6030f46d850edf87283de46"
            return paramDict
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let urlComponent = URLComponents(string: "https://api.themoviedb.org/3/movie/")!
        var urlRequest = URLRequest(url:urlComponent.url!.appendingPathComponent(path))
//        urlComponent.queryItems = query.map{ URLQueryItem(name: $0.key, value: $0.value)  }
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        
        return try URLEncoding.methodDependent.encode(urlRequest, with: params)
    }
    
}




