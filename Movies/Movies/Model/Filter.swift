//
//  Filter.swift
//  Movies
//
//  Created by Alfredo Luco on 07-02-21.
//

import Foundation

class Filter<T> {
    
    // Properties
    
    var id: UUID = UUID()
    var name: String
    var value: T? // T corresponde al tipo de data que va a contener el filtro (ej: String, Int, Data, etc)
    
    //Constructor
    
    init(_ name: String) {
        self.name = name
    }
    
}
