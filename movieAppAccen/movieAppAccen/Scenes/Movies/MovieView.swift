//
//  MovieView.swift
//  movieAppAccen
//
//  Created by Orlando Velasco on 21-10-23.
//

import SwiftUI

struct MovieView: View {
    @ObservedObject var viewModel: MovieViewModel
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(searchText: $searchText)
                    .onChange(of: searchText) { newValue in
                        viewModel.filterMovies(by: newValue)
                    }
                ScrollView {
                    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: UIScreen.main.bounds.width < 600 ? 2 : 3)
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.displayedMovies) { movie in
                            MovieCardView(movie: movie)
                        }
                    }
                    .padding()
                }
            }
            .onAppear(perform: viewModel.fetchMovies)
            .navigationTitle("Movies")
        }
    }
}
