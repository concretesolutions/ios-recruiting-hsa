//
//  LoggerMiddleware.swift
//  Concrete Challenge
//
//  Created by Jonathan Pacheco on 11/10/22.
//

import Foundation
import Redux

struct LoggerMiddleware: Middleware {
    
    func execute(state: AppState, action: Action) async -> Action? {
        debugPrint("📣 Redux action dispached: \(type(of: action))")
        return nil
    }
}
