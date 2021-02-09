//
//  GenreEntry.swift
//  concreteIOSRecruitChallenge
//
//  Created by Kristian Sthefan Cortes Prieto on 09-02-21.
//

import UIKit

class GenreEntry: NSObject {
    var id: Int?
    var name: String?
    
    init(_ json: [String:AnyObject]){
        if let data = json["id"] as? Int{ self.id = data }
        if let data = json["name"] as? String{ self.name = data }
    }
    func toJsonArray() -> [String:AnyObject]{
        var json = [String:AnyObject]()
        json["id"] = self.id as AnyObject?
        json["name"] = self.name as AnyObject?
        
        return json
    }
    
    static func arrayFromJson(_ json: [String:AnyObject]?) -> [GenreEntry]? {
        if(json == nil){
            return nil
        }
        let genresJson = json!["genres"] as! [Dictionary<String,AnyObject>]?
        if(genresJson == nil){
            return nil
        }
        var array:[GenreEntry] = []
        
        for data in genresJson!{
            array.append(GenreEntry(data))
        }
    
        return array
    }
}
