//
//  ServiceRouterConfiguration.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/2/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import Alamofire

//Protocolo que nos permitira configurar los routers para consumir api
//URLRequestConvertible es un protocolo de alamofire que nos ayuda a crear la url mas rapidamente y podra inyectarla directamente en el servicemanager.
protocol ServiceRouter: URLRequestConvertible {
    
    var method: HTTPMethod { get }
    var path: String { get }
    var bodyParameters: Parameters? { get }
    var queryItems: [URLQueryItem]? { get }
}

extension ServiceRouter{
    
    func asURLRequest() throws -> URLRequest {
        
        let urlString = Host.moviedb.rawValue.appending(path)
        var components = URLComponents.init(string: urlString)
        components?.queryItems = queryItems
        
        guard let url = components?.url else {
            throw AFError.explicitlyCancelled
        }
        var urlRequest = URLRequest.init(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        if let parameters = bodyParameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }
    
}
