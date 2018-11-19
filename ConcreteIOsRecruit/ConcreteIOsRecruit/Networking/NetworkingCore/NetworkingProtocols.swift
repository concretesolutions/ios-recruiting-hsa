//
//  Config.swift
//  ConcreteIOsRecruit
//
//  Created by Matías Contreras Selman on 11/17/18.
//  Copyright © 2018 Matias Contreras. All rights reserved.
//

import Foundation
import Alamofire

//This lets us configure many servers if there will be more than 1
protocol Server{
    var apiKey: String{get}
    var baseUrl: String{get}
}

protocol Endpoint {
    var server : Server{get}//URLComponents {get}
    var apiVersion : ApiVersion {get}
    var serverObject : ServerObject {get}
    var objectSorting: ObjectSorting{get}
    var method : HTTPMethod {get}
}

extension Endpoint{
    var fullUrl: String{
        return "\(server.baseUrl)/\(apiVersion.rawValue)/\(serverObject)/\(objectSorting)?api_key=\(server.apiKey)"
    }
    var urlRequest : URLRequest?{
        if let fullUrl = URL(string: self.fullUrl){
            var urlRequest = URLRequest(url: fullUrl)
            urlRequest.httpMethod = method.rawValue
            urlRequest.timeoutInterval = 10.0 //we counld define this in the endpoint protocol but for the sake of this example we will not do it
            return urlRequest
        }
        return nil
    }
}

protocol Storable{
    var key : DataManager.StoringKey{get}
}
