//
//  Registrables.swift
//  Concrete Challenge
//
//  Created by Jonathan Pacheco on 11/10/22.
//

import Foundation
import Injection
import Api

enum Registrables {
    
    static func registerDependencies() {
        Api.register()
        Container.default.register(type: Envirotment.self, value: AppEnvironment.develop)
    }
}
