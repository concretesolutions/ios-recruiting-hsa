//
//  CollectionExt.swift
//  Tuki Car
//
//  Created by Hector Morales on 7/16/20.
//  Copyright © 2020 Hector Morales. All rights reserved.
//

import Foundation

public extension Collection {

    /// Convert self to JSON String.
    /// Returns: the pretty printed JSON string or an empty string if any error occur.
    func json() -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
            return String(data: jsonData, encoding: .utf8) ?? "{}"
        } catch {
            print("json serialization error: \(error)")
            return "{}"
        }
    }
}
