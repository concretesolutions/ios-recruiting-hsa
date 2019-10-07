//
//  RemoteObjectMapper.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

class RemoteObjectMapper{
    
    static func map<T:Codable>(_ type: T, _ data: Data, from response: HTTPURLResponse) throws -> T {
        guard response.statusCode == 200,
            let items = try? JSONDecoder().decode(T.self, from: data) else {
                throw NetworkError.invalidData
        }
        return items
    }
}
