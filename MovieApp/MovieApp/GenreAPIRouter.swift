//
//  GenreAPIRouter.swift
//  MovieApp
//
//  Created by Sebastian Diaz on 4/7/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import Foundation
import Foundation
import Alamofire


enum GenreAPIRouter : URLRequestConvertible {
    
    case getGenre
    
    
    var method : HTTPMethod {
        switch self {
        case .getGenre:
            return .get
        }
    }
    
    var path : String {
        switch self {
        case .getGenre:
            return "list"
        }
    }
    
    var headers : HTTPHeaders{
        switch self {
        case .getGenre:
            return ["Content-Type":"application/x-www-form-urlencoded"]
        }
    }
    
    
    var params : [String:Any] {
        var paramDict : [String:Any] = [:]
        switch self {
        case .getGenre:
            paramDict["api_key"] = "6893e0b3a6030f46d850edf87283de46"
            return paramDict
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let urlComponent = URLComponents(string: "https://api.themoviedb.org/3/genre/movie/")!
        var urlRequest = URLRequest(url:urlComponent.url!.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        
        return try URLEncoding.methodDependent.encode(urlRequest, with: params)
    }
    
}
