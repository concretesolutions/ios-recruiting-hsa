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
    //MARK: Func
    func getIDCategory(name:String) -> Int {
        
        var respuesta:Int = 0
        
        genres.forEach { category in
            if category.name == name {
                respuesta = category.id
            }
        }
        
        return respuesta
    }
    
}

struct DataCategories:Decodable {
    
    var id:Int
    var name:String
}
