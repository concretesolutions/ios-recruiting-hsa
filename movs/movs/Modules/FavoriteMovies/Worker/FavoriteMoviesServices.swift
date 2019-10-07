//
//  FavoriteMoviesServices.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

enum FavoriteMoviesEndpoints: String{
    case genrelist  = "genre/movie/list"
}


enum FavoriteMoviesServices: ServiceRequest{
    
    case genreList
    
    var path: String{
        switch self {
        case .genreList:
            return FavoriteMoviesEndpoints.genrelist.rawValue
        }
    }
    
    var method: HTTPMethods{
       return .get
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
        case .genreList:
            return [QueryApiKey.api_key.rawValue : ExternalApiKeys.moviedb.rawValue]
        }
    }
    
}
