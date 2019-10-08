//
//  MovieListModel.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/2/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import CoreData

class MovieListModel: NSManagedObject, Codable {
    
    @NSManaged var page: Int
    @NSManaged var totalResults: Int
    @NSManaged var totalPages: Int
    @NSManaged var results: [MovieModel]
    @NSManaged var categoryId: String?
    
    enum CodingKeys: String, CodingKey{
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
        case categoryId
    }
    
    
    required convenience init(from decoder: Decoder) throws {
        
        guard let contextUserInfoKey = CodingUserInfoKey.managedObjectContext else { fatalError("cannot find context key") }
        
        guard let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext else { fatalError("cannot Retrieve context") }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "MovieListModel", in: managedObjectContext) else { fatalError("Cannot retrieve entity") }
        
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        guard let page = try container.decodeIfPresent(Int.self, forKey: .page) else { return }
        self.page = page
        
        guard let totalPages = try container.decodeIfPresent(Int.self, forKey: .totalPages) else { return }
        self.totalPages = totalPages
        
        guard let totalResults = try container.decodeIfPresent(Int.self, forKey: .totalResults) else{ return }
        self.totalResults = totalResults
        
        guard let results = try container.decodeIfPresent([MovieModel].self, forKey: .results) else { return }
        self.results = results
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(page, forKey: .page)
        try container.encode(totalResults, forKey: .totalResults)
        try container.encode(totalPages, forKey: .totalPages)
        try container.encode(results, forKey: .results)
        try container.encode(categoryId, forKey: .categoryId)
    }
}
