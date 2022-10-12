//
//  AppReducer.swift
//  Yuno Demo
//
//  Created by Jonathan Pacheco on 21/09/22.
//

import Foundation
import Redux

let appReducer: Reducer<AppState, Action> = combineReducers(reducers: moviesReducer)

let moviesReducer: Reducer<AppState, Action> = { (state: AppState, action: Action) -> AppState in
    state.with {
        switch action {
        case is Actions.LoadPopularMovieList:
            $0.movie.isLoading = true
        case let action as Actions.ReceivePopularMoviesList:
            if action.isError {
                $0.movie.isError = true
            } else {
                $0.movie.populars.append(contentsOf: action.movies)
            }
            $0.movie.isLoading = false
        case let action as Actions.ReceiveGenreList:
            $0.movie.genres = action.genres
        case let action as Actions.ToggleMovieToFavorites:
            if $0.movie.favorites.contains(action.movieId) {
                if let index = $0.movie.favorites.firstIndex(of: action.movieId) {
                    $0.movie.favorites.remove(at: index)
                }
            } else {
                $0.movie.favorites.append(action.movieId)
            }
        case let action as Actions.ReceiveFavoriteMovies:
            $0.movie.favorites = action.movieIds
        default: break
        }
    }
}

struct FavoriteMoviesSelector: Redux.Selector {
    
    func transform(state: AppState) -> [Movie] {
        state.movie.favorites.compactMap { (movieId: Int) in
            state.movie.populars.first { $0.id == movieId }
        }
    }
}
