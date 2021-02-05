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
    
    enum CodingKeys: CodingKey {
        case id,
             name
    }
    
    required convenience init(from decoder: Decoder) throws {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            throw DecoderConfigurationError.missingManagedObjectContext
        }
        let context = appDelegate.persistentContainer.viewContext
        
        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int32.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
}
