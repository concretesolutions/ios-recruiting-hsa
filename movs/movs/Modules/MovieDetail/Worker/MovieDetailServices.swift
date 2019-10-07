//
//  MovieDetailServices.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

enum MovieDetailServices{
    case getDetail(movieId: Int)
}

extension MovieDetailServices: ServiceRequest{
   
    var method: HTTPMethods {
        switch self {
        case .getDetail(_):
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getDetail(let movieId):
            return "movie/\(movieId)"
        }
    }
    
    var bodyParams: [String : Any]?{
        return nil
    }
    
    var headers: [String : String]?{
        return ["Content-Type":"application/json",
                "Accept": "application/json"]
    }
    
    var urlQueryParams: [String : Any]?{
        return [QueryApiKey.api_key.rawValue : ExternalApiKeys.moviedb.rawValue]
    }
    
    
}
