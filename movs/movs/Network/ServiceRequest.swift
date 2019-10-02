//
//  ApiRequest.swift
//  Re-Counter
//
//  Created by Andrés Alexis Rivas Solorzano on 7/29/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

protocol ServiceRequest {
    
    var path: String { get }
    var method: HTTPMethods { get }
    var headers: [String: String]? { get }
    var bodyParams: [String: Any]? { get }
    var urlQueryParams: [String: Any]? { get }
    
}
