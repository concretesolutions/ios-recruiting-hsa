//
//  GeneralHeaderEntry.swift
//  concreteIOSRecruitChallenge
//
//  Created by Kristian Sthefan Cortes Prieto on 08-02-21.
//

import UIKit

struct GeneralHeaderEntry<K> {
    var page: Int?
    var results: [K]?
    var total_pages: Int?
    var total_results: Int?
    var success: Bool?
    
    init(page: Int?, results: [K]?, total_pages: Int?, total_results: Int?, success: Bool?){
        self.page = page
        self.results = results
        self.total_pages = total_pages
        self.total_results = total_results
        self.success = success
    }
    
    init(_ json: [String:AnyObject]){
        if let data = json["page"] as? Int{ self.page = data }
        if let data = json["results"] as? [Dictionary<String,AnyObject>] { self.results = MovieEntry.arrayFromJson(data) as? [K] }
        if let data = json["total_pages"] as? Int{ self.total_pages = data }
        if let data = json["total_results"] as? Int{ self.total_results = data }
        if let data = json["success"] as? Bool{ self.success = data } else { self.success = true }
    }
    
    static func arrayFromJson(_ json: [String : AnyObject]?) -> GeneralHeaderEntry<K>?{
        if let data = json{
            return GeneralHeaderEntry<K>(data)
        }else { return nil }
        
    }
}
