//
//  File.swift
//  
//
//  Created by Jonathan Pacheco on 12/10/22.
//

import Foundation

public protocol Selector<State, Result> where State: Redux.State {
    
    associatedtype State
    associatedtype Result
    
    func transform(state: State) -> Result
}
