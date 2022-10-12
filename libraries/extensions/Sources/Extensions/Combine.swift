//
//  Combine.swift
//  
//
//  Created by Jonathan Pacheco on 11/10/22.
//

import Combine

public extension Publisher {
    
    func sink(receiveValue: @escaping ((Self.Output) -> Void)) -> AnyCancellable {
        sink(receiveCompletion: { _ in }, receiveValue: receiveValue)
    }
    
    func sink(storeIn anyCancellables: inout Set<AnyCancellable>) async throws -> Output {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Output, Error>) in
            self.sink { (completion: Subscribers.Completion<Failure>) in
                if case Subscribers.Completion<Failure>.failure(let failure) = completion {
                    continuation.resume(throwing: failure)
                }
            } receiveValue: { (output: Self.Output) in
                continuation.resume(returning: output)
            }
            .store(in: &anyCancellables)
        }
    }
    
    func compactMap<T>() -> Publishers.CompactMap<Self, T> where Output == Optional<T> {
        Publishers.CompactMap<Self, T>(upstream: self) { $0 }
    }
    
    func compactMap<T>(_ keyPath: KeyPath<Output, T?>) -> Publishers.CompactMap<Self, T> where Output == Optional<T> {
        Publishers.CompactMap<Self, T>(upstream: self) { $0[keyPath: keyPath] }
    }
    
    static func just(_ output: Output) -> AnyPublisher<Output, Failure> {
        Just<Output>(output)
            .setFailureType(to: Failure.self)
            .eraseToAnyPublisher()
    }
    
    static func empty() -> AnyPublisher<Output, Failure> {
        Empty<Output, Failure>(completeImmediately: true)
            .eraseToAnyPublisher()
    }
    
    static func never() -> AnyPublisher<Output, Failure> {
        Empty<Output, Failure>(completeImmediately: false)
            .eraseToAnyPublisher()
    }
    
    static func error(_ error: Failure) -> AnyPublisher<Output, Failure> {
        Fail<Output, Failure>(error: error)
            .eraseToAnyPublisher()
    }
    
    func assign<Root>(to keyPath: ReferenceWritableKeyPath<Root, Self.Output>,
                      on object: Root) -> AnyCancellable where Root: AnyObject {
        sink { [weak object] (output: Self.Output) in
            object?[keyPath: keyPath] = output
        }
    }
    
    func convertFailureToNever() -> AnyPublisher<Self.Output, Never> {
        `catch` { _ in AnyPublisher<Self.Output, Never>.never() }
            .eraseToAnyPublisher()
    }
}
