//
//  MovieVideoModel.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/7/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import CoreData

class MovieVideoModel: NSManagedObject, Codable{
    
    @NSManaged var id: Int
    @NSManaged var videoList: [MediaVideoModel]
    
    enum CodingKeys: String, CodingKey{
        case id
        case videoList = "results"
    }
    
    required convenience init(from decoder: Decoder) throws {
        
        guard let contextUserInfoKey = CodingUserInfoKey.managedObjectContext else { fatalError("cannot find context key") }
        
        guard let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext else { fatalError("cannot Retrieve context") }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "MovieVideoModel", in: managedObjectContext) else { fatalError("Cannot retrieve entity") }
        
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        guard let id = try container.decodeIfPresent(Int.self, forKey: .id) else { return }
        self.id = id
        
        guard let videoList = try container.decodeIfPresent([MediaVideoModel].self, forKey: .videoList) else { return }
        self.videoList = videoList
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
    
        
    }
}

class MediaVideoModel: NSManagedObject, Codable, NSCoding{
    
    @NSManaged var id: String
    @NSManaged var key: String
    @NSManaged var site: String
    @NSManaged var name: String
    
    enum CodingKeys: String, CodingKey{
        case id
        case key
        case site
        case name
    }
    
//    Coredata is not fun
//    BOILERPLATE
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: CodingKeys.id.rawValue)
        aCoder.encode(key, forKey: CodingKeys.key.rawValue)
        aCoder.encode(site, forKey: CodingKeys.site.rawValue)
        aCoder.encode(name, forKey: CodingKeys.name.rawValue)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        let managedObjectContext = DataBaseManager.shared.coreStack.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "MediaVideoModel", in: managedObjectContext) else { fatalError("Cannot retrieve entity") }
        
        
        self.init(entity: entity, insertInto: nil)
        
        guard let id = aDecoder.decodeObject(forKey: CodingKeys.id.rawValue) as? String else { return }
        self.id = id
        
        guard let key = aDecoder.decodeObject(forKey: CodingKeys.key.rawValue) as? String else { return }
        self.key = key
        
        guard let site = aDecoder.decodeObject(forKey: CodingKeys.site.rawValue) as? String else { return }
        self.site = site
        
        guard let name = aDecoder.decodeObject(forKey: CodingKeys.name.rawValue) as? String else { return }
        self.name = name
        
    }
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    required convenience init(from decoder: Decoder) throws {
        
        guard let contextUserInfoKey = CodingUserInfoKey.managedObjectContext else { fatalError("cannot find context key") }
        
        guard let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext else { fatalError("cannot Retrieve context") }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "MediaVideoModel", in: managedObjectContext) else { fatalError("Cannot retrieve entity") }
        
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        guard let id = try container.decodeIfPresent(String.self, forKey: .id) else { return }
        self.id = id
        
        guard let name = try container.decodeIfPresent(String.self, forKey: .name) else { return }
        self.name = name
        
        guard let site = try container.decodeIfPresent(String.self, forKey: .site) else{ return }
        self.site = site
        
        guard let key = try container.decodeIfPresent(String.self, forKey: .key) else { return }
        self.key = key
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(site, forKey: .site)
        try container.encode(key, forKey: .key)
        
    }
}
