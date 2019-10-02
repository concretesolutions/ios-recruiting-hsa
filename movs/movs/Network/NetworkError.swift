//
//  NetworkError.swift
//  Re-Counter
//
//  Created by Andrés Alexis Rivas Solorzano on 7/29/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

enum NetworkError: Error{
    case unknow
    case noInternet
    case invalidData
}

extension NetworkError: LocalizedError{
    var localizedDescription: String{
        switch self {
        case .unknow:
            return "Unknow error, please report this."
        case .noInternet:
            return "No internet connection available"
        case .invalidData:
            return "Server is returning corrupted data"
        }
    }
}
