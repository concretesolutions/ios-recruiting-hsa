//
//  Genero.swift
//  Movs
//
//  Created by Jose Antonio Aravena on 9/5/19.
//  Copyright © 2019 Jose Antonio Aravena. All rights reserved.
//

import Foundation

class Genero:  Decodable{
    var id = 0
    var nombre = ""
    
    enum CodingKeys : String, CodingKey {
        case id
        case nombre = "name"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(nombre, forKey: "name")
    }
    
}
