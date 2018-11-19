//
//  DataManager.swift
//  ConcreteIOsRecruit
//
//  Created by Matías Contreras Selman on 11/19/18.
//  Copyright © 2018 Matias Contreras. All rights reserved.
//

import Foundation

struct DataManager{
    func save(data: Storable) {
        let storingKey = data.key
        UserDefaults.standard.set(data, forKey: storingKey)
    }
    
    // Retrieve an Array of products
    func retrieve<T>() -> [T]? {
        guard let data = NSKeyedUnarchiver.unarchiveObject(withFile: productsFile.path) as? Data else { return nil }
        do {
            let products = try PropertyListDecoder().decode([Product].self, from: data)
            return products
        } catch {
            print("Retrieve Failed")
            dfsdfasdsad
        }
    }
}

