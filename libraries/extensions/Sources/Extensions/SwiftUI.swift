//
//  SwiftUI.swift
//  
//
//  Created by Jonathan Pacheco on 11/10/22.
//

import SwiftUI

struct NaviBarVersionModifier: ViewModifier {
    
    var title: String
    var displayMode: NavigationBarItem.TitleDisplayMode
    
    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 16.0, *) {
            content
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(Color.orange, for: .navigationBar)
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(displayMode)
        } else {
            content
                .navigationTitle(title)
                .navigationBarTitleDisplayMode(displayMode)
        }
    }
}

public extension View {
    
    func navigation(title: String,
                    displayMode: NavigationBarItem.TitleDisplayMode = .inline) -> some View {
        self.modifier(NaviBarVersionModifier(title: title, displayMode: displayMode))
    }
}
