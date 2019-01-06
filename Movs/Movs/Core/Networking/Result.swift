//
//  Result.swift
//  TMDB Reloaded
//
//  Created by Miguel Duran on 1/4/19.
//  Copyright © 2018 Miguel Duran. All rights reserved.
//

import Foundation

enum Result<Wrapped> {
    case failure(Error)
    case success(Wrapped)
    
    init(closure: () throws -> Wrapped) {
        do {
            self = .success(try closure())
        } catch {
            self = .failure(error)
        }
    }
    
    func get() throws -> Wrapped {
        switch self {
        case let .success(value): return value
        case let .failure(error): throw error
        }
    }
}
