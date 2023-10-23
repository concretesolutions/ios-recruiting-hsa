//
//  UserDefaultsManager.swift
//  movieAppAccen
//
//  Created by Orlando Velasco on 20-10-23.
//

import Foundation

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    private init() {}
    
    func set<T: Codable>(_ value: T, forKey key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(value) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    func get<T: Codable>(forKey key: String) -> T? {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: key),
           let value = try? decoder.decode(T.self, from: data) {
            return value
        }
        return nil
    }
    
    func remove(forKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
