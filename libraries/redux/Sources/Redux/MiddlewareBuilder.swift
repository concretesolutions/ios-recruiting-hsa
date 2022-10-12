//
//  MiddlewareBuilder.swift
//  
//
//  Created by Jonathan Pacheco on 22/09/22.
//

import Foundation

@resultBuilder
public struct MiddlewareBuilder<State> {
    
    public static func buildArray(
        _ components: [MiddlewareGroup<State>]
    ) -> [any Middleware] {
        components
    }

    public static func buildBlock(
        _ components: any Middleware...
    ) -> any Middleware {
        MiddlewareGroup<State>(components)
    }

    public static func buildEither<M: Middleware>(
        first component: M
    ) -> [any Middleware] {
        [component]
    }

    public static func buildEither<M: Middleware>(
        second component: M
    ) -> [any Middleware] {
        [component]
    }

    public static func buildOptional(
        _ component: (any Middleware)?
    ) -> [any Middleware]? {
        if let component {
            return [component]
        }
        return nil
    }
}
