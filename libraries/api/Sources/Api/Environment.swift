//
//  File.swift
//  
//
//  Created by Jonathan Pacheco on 11/10/22.
//

import Foundation

public protocol Envirotment {
    
    var baseUrl: String { get }
    var port: Int? { get }
    var scheme: String { get }
    var apiVersion: String { get }
}
