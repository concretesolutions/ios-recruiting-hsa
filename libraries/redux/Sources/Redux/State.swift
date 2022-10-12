//
//  AppState.swift
//  Yuno Demo
//
//  Created by Jonathan Pacheco on 21/09/22.
//

import Foundation

public protocol State: Equatable {
    
    static var initialValue: Self { get }
}

public extension State {
    
    @inlinable func with(_ callback: (inout Self) throws -> Void) rethrows -> Self {
        var copy = self
        try callback(&copy)
        return copy
    }
}
