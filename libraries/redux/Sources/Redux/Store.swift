//
//  Store.swift
//  Yuno Demo
//
//  Created by Jonathan Pacheco on 21/09/22.
//

import Foundation
import Combine

public final actor Store<State>: ObservableObject where State: Redux.State {
    
    @MainActor @Published public private(set) var state: State = .initialValue
    private let reducer: Reducer<State, Action>
    private nonisolated let middleware: any Middleware
    
    public init(reducer: @escaping Reducer<State, Action>, @MiddlewareBuilder<State> middleware: () -> any Middleware) {
        self.reducer = reducer
        self.middleware = middleware()
    }
    
    public func dispatch(action: Action) async {
        middleware.proccessAction(action, store: self)
        await MainActor.run {
            let current = state
            let newState = reducer(current, action)
            state = newState
        }
    }
}

public extension Store {
    
    func dispatch(_ factory: () async -> Action) async {
        await dispatch(action: await factory())
    }
    
    func dispatch<Seq: AsyncSequence>(
        sequence: Seq
    ) async throws where Seq.Element == Action {
        for try await action in sequence {
            await dispatch(action: action)
        }
    }
    
    func dispatch(future: Future<Action?, Never>) {
        var subscription: AnyCancellable?
        subscription = future.sink { _ in
            if subscription != nil {
                subscription = nil
            }
        } receiveValue: { action in
            guard let action = action else {
                return
            }
            Task {
                await self.dispatch(action: action)
            }
        }
    }
    
    func dispatch<P: Publisher>(publisher: P) where P.Output == Action, P.Failure == Never {
        var subscription: AnyCancellable?
        subscription = publisher.sink { _ in
            if subscription != nil {
                subscription = nil
            }
        } receiveValue: { action in
            Task {
                await self.dispatch(action: action)
            }
        }
    }
}

public extension Store {
    
    @MainActor func selector<T>(keyPath: KeyPath<State, T>) -> T {
        state[keyPath: keyPath]
    }
    
    @MainActor func selector<S, T>(_ selector: S) -> T where S: Selector, T == S.Result, S.State == State {
        selector.transform(state: state)
    }
}

