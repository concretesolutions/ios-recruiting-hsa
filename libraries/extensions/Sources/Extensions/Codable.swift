//
//  Codable.swift
//  
//
//  Created by Jonathan Pacheco on 11/10/22.
//

import Foundation

public extension Decodable {
    
    init(from data: Data) throws {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        self = try decoder.decode(Self.self, from: data)
    }
    
    init(from json: [String: Any]) throws {
        let data = try JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
        try self.init(from: data)
    }
}

public extension Encodable {
    
    func toJson() throws -> [String: Any] {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let data = try encoder.encode(self)
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        guard let json = jsonObject as? [String: Any] else {
            return [:]
        }
        return json
    }
}
