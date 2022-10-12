//
//  AppState.swift
//  Yuno Demo
//
//  Created by Jonathan Pacheco on 21/09/22.
//

import Foundation
import Redux

struct AppState {
    
    var movie: MoviesState = .initialValue
    
    private init() {}
}

extension AppState: State {
    
    static var initialValue: AppState { AppState() }
}
