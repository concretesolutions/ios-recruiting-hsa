//
//  KeychainManager.swift
//  movieAppAccen
//
//  Created by Orlando Velasco on 19-10-23.
//

import Foundation
import KeychainSwift

class KeychainManager {
    
    private let keychain = KeychainSwift()
    
    static let shared = KeychainManager()
    
    private init() {}
    
    func save(key: String, value: String) {
        keychain.set(value, forKey: key)
    }
    
    func get(key: String) -> String? {
        return keychain.get(key)
    }
    
    func delete(key: String) {
        keychain.delete(key)
    }
}
