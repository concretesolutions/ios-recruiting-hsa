//
//  Router.swift
//  AccentureChallenge
//
//  Created by Jaime on 2/4/19.
//  Copyright © 2019 Jaime. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public enum Router: URLRequestConvertible {
    enum Constants {
        static let apiBaseURLPath = "https://api.themoviedb.org/3"
        static let apiKey = "90b8d5df8463a9e6d1a6a797d8710fb8"
        static let language = "en-US"
        static let timeoutIntervalTime = 30 * 1000
        //static let authenticationToken = "Basic xxx"
    }
    
    case getPopularMovies(page: Int)
    case getMovieTypes()
    
    var method: HTTPMethod {
        switch self {
//    case .register, .logIn, .authorizeDevice, .basicInformation, .validateSMS:
//            return .post
        case .getPopularMovies, .getMovieTypes:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getPopularMovies:
            return "/movie/popular"
        case .getMovieTypes:
            return "/genre/movie/list"

        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case .getPopularMovies(let page):
            return ["api_key": Constants.apiKey, "language": Constants.language, "page": page]
        case .getMovieTypes():
            return ["api_key": Constants.apiKey, "language": Constants.language]
//        default:
//            return [:]
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        
        let url = try Constants.apiBaseURLPath.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(Constants.timeoutIntervalTime)
        print(parameters)
        return try URLEncoding.default.encode(request, with: parameters)
    }
}
