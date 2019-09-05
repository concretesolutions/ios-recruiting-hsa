//
//  ListaGeneros.swift
//  Movs
//
//  Created by Jose Antonio Aravena on 9/5/19.
//  Copyright © 2019 Jose Antonio Aravena. All rights reserved.
//

import Foundation

class ListaGeneros:Decodable {
    var lista: [Genero] = Array()
    
    enum CodingKeys : String, CodingKey {
        case lista = "genres"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(lista, forKey: "generes")
    }
}
