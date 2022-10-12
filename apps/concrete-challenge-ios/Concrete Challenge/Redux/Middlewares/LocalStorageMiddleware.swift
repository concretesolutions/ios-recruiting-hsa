//
//  LocalStorageMiddleware.swift
//  Concrete Challenge
//
//  Created by Jonathan Pacheco on 12/10/22.
//

import Foundation
import SwiftUI
import Redux

final class LocalStorageMiddleware: Middleware {
    
    @UserDefault(key: "favorite_movies_key", default: []) var favoriteMovieIds: [Int]
    
    func execute(state: AppState, action: Action) async -> Action? {
        switch action {
        case is Actions.ToggleMovieToFavorites:
            favoriteMovieIds = state.movie.favorites
        case is Actions.LoadFavoriteMovies:
            return Actions.ReceiveFavoriteMovies(movieIds: favoriteMovieIds)
        default: break
        }
        return nil
    }
}
