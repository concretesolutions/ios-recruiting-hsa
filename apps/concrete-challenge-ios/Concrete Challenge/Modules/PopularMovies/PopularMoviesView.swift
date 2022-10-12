//
//  PopularMoviesView.swift
//  Concrete Challenge
//
//  Created by Jonathan Pacheco on 11/10/22.
//

import SwiftUI

struct PopularMoviesView: View {
    
    @EnvironmentObject private var store: Store
    @State private var searchText: String = ""
    private let columns = [GridItem(.flexible(), spacing: 8.0), GridItem(.flexible(), spacing: 8.0)]
    
    var filteredMovies: [Movie] {
        store.state.movie.populars
            .filter {
                if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    return true
                }
                return $0.title.contains(searchText)
            }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                if store.state.movie.isLoading {
                    ProgressView()
                } else if store.state.movie.isError {
                    VStack {
                        Image(systemName: "x.circle.fill")
                            .resizable()
                            .frame(width: 44.0, height: 44.0)
                            .foregroundColor(.red)
                        Text("Error trying to load popular movies")
                            .font(.system(size: 20.0))
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                } else if !searchText.isEmpty && filteredMovies.isEmpty {
                    VStack {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 44.0, height: 44.0)
                        Text("There aren't search results for '\(searchText)'")
                            .font(.system(size: 20.0))
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    .frame(maxHeight: .infinity)
                } else {
                    ScrollView {
                        ScrollViewReader { (proxy: ScrollViewProxy) in
                            LazyVGrid(columns: columns, content: {
                                ForEach(filteredMovies, id: \.id) { (movie: Movie) in
                                    NavigationLink {
                                        MovieDetailView(movie: movie)
                                    } label: {
                                        PopularMovieCardView(movie: movie)
                                            .frame(height: 260.0)
                                            .clipped()
                                    }
                                }
                            })
                            .padding()
                        }
                    }
                }
            }
            .navigation(title: "Movies")
            .navigationViewStyle(.stack)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .accentColor(.black)
            .task {
                await store.dispatch(action: Actions.LoadPopularMovieList())
                await store.dispatch(action: Actions.LoadGenreList())
            }
        }
    }
    
    struct PopularMoviesView_Previews: PreviewProvider {
        static var previews: some View {
            PreviewView {
                PopularMoviesView()
            }
        }
    }
}
