//
//  Filter.swift
//  Movies
//
//  Created by Alfredo Luco on 07-02-21.
//

import Foundation

class Filter<T> {
    
    var id: UUID = UUID()
    var name: String
    var value: T?
    
    init(_ name: String) {
        self.name = name
    }
    
}
