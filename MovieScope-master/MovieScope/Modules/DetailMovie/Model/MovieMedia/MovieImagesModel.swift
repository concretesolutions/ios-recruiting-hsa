//
//  MovieDetailImagesModel.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/7/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import CoreData

class MovieImagesModel: NSManagedObject, Codable{
    
    @NSManaged var id: Int
    @NSManaged var backdrops: [MediaImageModel]
    @NSManaged var posters: [MediaImageModel]
    
    enum CodingKeys: String, CodingKey{
        case id
        case backdrops
        case posters
    }
    
    required convenience init(from decoder: Decoder) throws {
        
        guard let contextUserInfoKey = CodingUserInfoKey.managedObjectContext else { fatalError("cannot find context key") }
        
        guard let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext else { fatalError("cannot Retrieve context") }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "MovieImagesModel", in: managedObjectContext) else { fatalError("Cannot retrieve entity") }
        
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        guard let id = try container.decodeIfPresent(Int.self, forKey: .id) else { return }
        self.id = id
        
        guard let backdrops = try container.decodeIfPresent([MediaImageModel].self, forKey: .backdrops) else{return}
        self.backdrops = backdrops
        
        guard let posters = try container.decodeIfPresent([MediaImageModel].self, forKey: .posters) else { return }
        self.posters = posters
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(backdrops, forKey: .backdrops)
        try container.encode(posters, forKey: .posters)
    }
    
}

class MediaImageModel: NSManagedObject, Codable, NSCoding{
   
    @NSManaged var filePath: String
    
    enum CodingKeys: String, CodingKey{
        case filePath = "file_path"
    }
    
    
//    CORE DATA BOILERPLATE
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(filePath, forKey: CodingKeys.filePath.rawValue)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let managedObjectContext = DataBaseManager.shared.coreStack.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "MediaImageModel", in: managedObjectContext) else { fatalError("Cannot retrieve entity") }
        
        
        self.init(entity: entity, insertInto: nil)
        guard let filePath = aDecoder.decodeObject(forKey: CodingKeys.filePath.rawValue) as? String else { return }
        self.filePath = filePath
        
    }
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    required convenience init(from decoder: Decoder) throws {
        
        guard let contextUserInfoKey = CodingUserInfoKey.managedObjectContext else { fatalError("cannot find context key") }
        
        guard let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext else { fatalError("cannot Retrieve context") }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "MediaImageModel", in: managedObjectContext) else { fatalError("Cannot retrieve entity") }
        
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        guard let filePath = try container.decodeIfPresent(String.self, forKey: .filePath) else { return }
        self.filePath = filePath
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(filePath, forKey: .filePath)
    }
}
