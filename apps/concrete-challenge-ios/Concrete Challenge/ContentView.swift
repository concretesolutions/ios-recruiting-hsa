//
//  ContentView.swift
//  Concrete Challenge
//
//  Created by Jonathan Pacheco on 11/10/22.
//

import SwiftUI
import Extensions

struct ContentView: View {

    init() {
        UITabBar.appearance().barTintColor = .orange
    }
    
    var body: some View {
        TabView {
            PopularMoviesView()
                .tabItem {
                    Label("Movies", systemImage: "list.bullet")
                    Text("Movies")
                }
            
            FavoriteMoviesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                    Text("Favorites")
                        .foregroundColor(.black)
                }
        }
        .accentColor(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView {
            ContentView()
        }
    }
}
