//
//  UserDefault.swift
//  Concrete Challenge
//
//  Created by Jonathan Pacheco on 12/10/22.
//

import Foundation

@propertyWrapper
struct UserDefault<Value> {
    let key: String
    let `default`: Value
    var container: UserDefaults = .standard
    
    var wrappedValue: Value {
        get { container.object(forKey: key) as? Value ?? `default` }
        set { container.set(newValue, forKey: key) }
    }
}
