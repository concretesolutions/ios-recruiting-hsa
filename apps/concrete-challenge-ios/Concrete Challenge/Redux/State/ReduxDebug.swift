//
//  ReduxDebug.swift
//  Concrete Challenge
//
//  Created by Jonathan Pacheco on 11/10/22.
//

import Foundation
import Redux
import SwiftUI

struct DebugMiddleware: Middleware {
    
    func execute(state: AppState, action: Action) async -> Action? {
        return nil
    }
}
//private let debugStore: Store = Store(reducer: { (state: AppState, _) in state }) { DebugMiddleware() }

struct PreviewView<Content>: View where Content: View {
    
    private let contentView: () -> Content
    
    init(@ViewBuilder view: @escaping () -> Content) {
        contentView = view
    }
    
    var body: some View {
        contentView()
            .environmentObject(store)
            .previewLayout(.sizeThatFits)
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            .previewDisplayName("Default preview")
    }
}
