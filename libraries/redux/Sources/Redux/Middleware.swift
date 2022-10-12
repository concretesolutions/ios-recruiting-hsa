//
//  Middleware.swift
//  
//
//  Created by Jonathan Pacheco on 21/09/22.
//

import Foundation

public protocol Middleware<State> {
    
    associatedtype State
    
    func execute(state: State, action: Action) async -> Action?
}

internal protocol _MiddlewareGroup {
    
    var middlewares: [any Middleware] { get }
}

public struct AnyMiddleware<State>: Middleware {
    
    private let wrappedMiddleware: (State, Action) async -> Action?

    public init<M: Middleware>(_ middleware: M) where M.State == State {
        self.wrappedMiddleware = middleware.execute(state:action:)
    }

    public func execute(state: State, action: Action) async -> Action? {
        await wrappedMiddleware(state, action)
    }
}

public struct MiddlewareGroup<State>: Middleware, _MiddlewareGroup {
    
    internal let middlewares: [any Middleware]
    
    public init(_ middlewares: any Middleware...) {
        self.middlewares = middlewares
    }
    
    public init(_ middlewares: [any Middleware]) {
        self.middlewares = middlewares
    }
    
    public init(@MiddlewareBuilder<State> builder: () -> [any Middleware]) {
        self.middlewares = builder()
    }
    
    public func execute(state: State, action: Action) async -> Action? { nil }
}

public extension Middleware {
    
    func eraseToAnyMiddleware() -> AnyMiddleware<State> {
        self as? AnyMiddleware<State> ?? AnyMiddleware<State>(self)
    }
}

extension Middleware {
    
    internal nonisolated func proccessAction<S>(_ action: Action, store: Store<S>) {
        if let group = self as? _MiddlewareGroup {
            group.middlewares.forEach { (middleware: any Middleware) in
                middleware.proccessAction(action, store: store)
            }
            return
        }
        Task {
            guard let state = await store.state as? State,
                let action = await execute(state: state, action: action) else {
                return
            }
            await store.dispatch(action: action)
        }
    }
}
