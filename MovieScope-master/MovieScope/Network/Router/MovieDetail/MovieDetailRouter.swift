//
//  MovieDetailRouter.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/5/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import Alamofire

enum MovieDetailRouter{
    case getDetail(movieId: Int)
    case getImages(movieId: Int)
    case getVideos(movieId: Int)
}

extension MovieDetailRouter: ServiceRouter{
    
    var method: HTTPMethod {
        switch self {
        case .getDetail(_), .getImages(_), .getVideos(_):
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getDetail(let movieId):
            return "movie/\(movieId)"
        case .getImages(let movieId):
            return"movie/\(movieId)/images"
        case .getVideos(let movieId):
            return "movie/\(movieId)/videos"
        }
    }
    
    var bodyParameters: Parameters? {
        // por los momentos ninguno de los cases requere de un body pero en caso de que se necesite solo hace falta agregar un switch
       return nil
    }
    
    var queryItems: [URLQueryItem]? {
        //Todos los request de este router usan este queryitem
        return [URLQueryItem.init(name: QueryApiKey.api_key.rawValue, value: ExternalApiKeys.moviedb.rawValue)]
    }
    
    
}
