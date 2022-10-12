//
//  FavoriteMovieButton.swift
//  Concrete Challenge
//
//  Created by Jonathan Pacheco on 12/10/22.
//

import SwiftUI

struct FavoriteMovieButton: View {
    
    @EnvironmentObject private var store: Store
    let movieId: Int
    
    var body: some View {
        Button {
            Task {
                await store.dispatch(action: Actions.ToggleMovieToFavorites(movieId: movieId))
            }
        } label: {
            if store.state.movie.favorites.contains(movieId) {
                Image(systemName: "heart.fill")
                    .foregroundColor(Color.orange)
            } else {
                Image(systemName: "heart.fill")
                    .foregroundColor(Color.gray)
            }
        }
    }
}

struct FavoriteMovieButton_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView {
            FavoriteMovieButton(movieId: 1)
        }
    }
}
