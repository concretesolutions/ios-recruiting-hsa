//
//  Concrete_ChallengeApp.swift
//  Concrete Challenge
//
//  Created by Jonathan Pacheco on 11/10/22.
//

import SwiftUI
import Redux

typealias Store = Redux.Store<AppState>
let store: Store = Store(reducer: appReducer) { appMiddleware }

@main
struct Concrete_ChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
                .task {
                    Registrables.registerDependencies()
                    await store.dispatch(action: Actions.LoadFavoriteMovies())
                }
        }
    }
}
