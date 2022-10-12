//
//  Reducer.swift
//  Yuno Demo
//
//  Created by Jonathan Pacheco on 21/09/22.
//

import Foundation

public typealias Reducer<State, Action> = (State, Action) -> State

public func combineReducers<State, Action>(reducers: Reducer<State, Action>...) -> Reducer<State, Action> {
    { (state: State, action: Action) -> State in
        reducers.reduce(state) { $1($0, action) }
    }
}
