//
//  DataManager.swift
//  ConcreteIOsRecruit
//
//  Created by Matías Contreras Selman on 11/19/18.
//  Copyright © 2018 Matias Contreras. All rights reserved.
//

import Foundation

struct DataManager{
    
    enum StoringKey: String, Codable{
        case favorites
    }
    
    func save<T: Codable>(object: T) {
        guard let storableObject = object as? Storable else{
            debugPrint("The object does not conform to protocol Storable")
            return
        }
        
        let storingKey = storableObject.key
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(object) {//try? encoder.encode(codableObject) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: storingKey.rawValue)
            defaults.synchronize()
        }
    }
    
    func retrieve<T: Decodable>(decodingType: T.Type, storingKey: StoringKey) -> T? {
        /*guard let storableObject = object as? Storable else{
            debugPrint("The object does not conform to protocol Storable")
            return nil
        }*/
        //let storingKey = decodingType().key
        //let storingKey = object.key
        
        if let data = UserDefaults.standard.data(forKey: storingKey.rawValue){
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode(decodingType, from: data){
                return decoded// as? T
            }
        }
        return nil
        //if let objectFromDefaults = objectFromDefaults{
        
        //}
        
    }
}

