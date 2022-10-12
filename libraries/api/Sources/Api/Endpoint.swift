//
//  Endpoint.swift
//  
//
//  Created by Jonathan Pacheco on 11/10/22.
//

import Foundation

public enum EndpointMethod: String {
    
    case get, post, put, patch, delete
}

public protocol Endpoint: Encodable {
    
    typealias Method = EndpointMethod
    
    var path: String { get }
    var method: Method { get }
    var headers: [String: String] { get }
    var params: [String: Any] { get }
}

public extension Endpoint {
    
    var headers: [String: String] { [:] }
    var params: [String: Any] { [:] }
}
