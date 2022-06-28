//
//  ResponseCategories.swift
//  InformationMovies
//
//  Created by Cristian Bahamondes on 27-06-22.
//

import Foundation

struct ResponseCategories:Decodable {
    
    //MARK: Singleton
    static var shared = ResponseCategories()
    //MARK: Properties
    var genres:[DataCategories]
    //MARK: Init
    init(genres:[DataCategories] = []) {
        self.genres = genres
    }
    
}

struct DataCategories:Decodable {
    
    var id:Int
    var name:String
}
