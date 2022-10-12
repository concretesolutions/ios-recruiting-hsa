//
//  FavoriteMoviesView.swift
//  Concrete Challenge
//
//  Created by Jonathan Pacheco on 12/10/22.
//

import SwiftUI

struct FavoriteMoviesView: View {
    
    @EnvironmentObject private var store: Store
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            if store.state.movie.favorites.isEmpty {
                Text("You don't have favorite movies")
                    .navigation(title: "Favorites")
            } else {
                List {
                    ForEach(store.selector(FavoriteMoviesSelector()), id: \.id) { (movie: Movie) in
                        ZStack(alignment: .leading) {
                            NavigationLink {
                                MovieDetailView(movie: movie)
                            } label: {
                                EmptyView()
                            }
                            .opacity(0)
                            FavoriteMovieCardView(movie: movie)
                        }
                        .swipeActions {
                            Button {
                                Task {
                                    await store.dispatch(action: Actions.ToggleMovieToFavorites(movieId: movie.id))
                                }
                            } label: {
                                Text("Unfavorite")
                                    .foregroundColor(.white)
                            }
                            .tint(Color.red)
                        }
                    }
                }
                .listStyle(.plain)
                .navigation(title: "Favorites")
            }
        }
    }
}

struct FavoriteMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView {
            FavoriteMoviesView()
        }
    }
}
