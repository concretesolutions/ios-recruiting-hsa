//
//  AppEnvironmnet.swift
//  Concrete Challenge
//
//  Created by Jonathan Pacheco on 11/10/22.
//

import Foundation
import Api

enum AppEnvironment: Envirotment {
    
    case develop
    
    var baseUrl: String {
        switch self {
        case .develop: return "api.themoviedb.org"
        }
    }
    
    var apiVersion: String {
        switch self {
        case .develop: return "/3"
        }
    }
    
    var port: Int? { nil }
    
    var scheme: String { "https" }
}
