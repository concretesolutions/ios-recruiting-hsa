//
//  ContentView.swift
//  movieAppAccen
//
//  Created by Orlando Velasco on 19-10-23.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            MovieView(viewModel: MovieViewModel())
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Movies")
                }
                .tag(0)
            
            FavoriteMoviesView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
                .tag(1)
        }
    }
}
