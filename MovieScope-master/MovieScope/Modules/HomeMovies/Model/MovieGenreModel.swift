//
//  MovieGenreModel.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/12/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import CoreData

class MovieGenreModel: NSManagedObject, Codable, NSCoding {
    
    @NSManaged var id: Int
    @NSManaged var name: String
    
    enum CodingKeys: String, CodingKey{
        case id
        case name
    }
    
    //BOILERPLATE
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: CodingKeys.id.rawValue)
        aCoder.encode(name, forKey: CodingKeys.name.rawValue)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let managedObjectContext = DataBaseManager.shared.coreStack.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "MovieGenreModel", in: managedObjectContext) else { fatalError("Cannot retrieve entity") }
        
        
        self.init(entity: entity, insertInto: nil)
       
//        guard let id = Int(aDecoder.decodeInt64(forKey: CodingKeys.id.rawValue)) else { return }
        self.id =  Int(aDecoder.decodeInt64(forKey: CodingKeys.id.rawValue))
        
        guard let name = aDecoder.decodeObject(forKey: CodingKeys.name.rawValue) as? String else { return}
        self.name = name
    }
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    required convenience init(from decoder: Decoder) throws {
        
        guard let contextUserInfoKey = CodingUserInfoKey.managedObjectContext else { fatalError("cannot find context key") }
        
        guard let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext else { fatalError("cannot Retrieve context") }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "MovieGenreModel", in: managedObjectContext) else { fatalError("Cannot retrieve entity") }
        
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        guard let id = try container.decodeIfPresent(Int.self, forKey: .id) else { return }
        self.id = id
        
        guard let name = try container.decodeIfPresent(String.self, forKey: .name) else { return }
        self.name = name
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
       
    }
    
}
