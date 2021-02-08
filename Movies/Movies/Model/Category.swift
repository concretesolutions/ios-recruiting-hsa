//
//  Category.swift
//  Movies
//
//  Created by Alfredo Luco on 05-02-21.
//

import Foundation
import CoreData
import UIKit

class Category: NSManagedObject, Decodable {
    
    //Coding Keys to map. Aqui van los labels que aparecen en la respuesta del servicio de la api, los cuales van a ser mapeados

    
    enum CodingKeys: CodingKey {
        case id,
             name
    }
    
    //Constructor
    
    required convenience init(from decoder: Decoder) throws {
        
        //Se inicializa el context de core data
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        let context = appDelegate.persistentContainer.viewContext
        
        //Se inicializa el objeto en base al context
        
        self.init(context: context)
        
        //Mapping de propiedades
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int32.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
}
