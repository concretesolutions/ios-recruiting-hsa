//
//  ErrorEntity.swift
//  ios-recruiting-hsa
//
//  Created on 07-08-19.
//

struct ErrorEntity: Codable {
    let statusMessage: String
    let statusCode: Int
    
    private enum CodingKeys: String, CodingKey {
        case statusMessage = "status_message"
        case statusCode = "status_code"
    }
}
