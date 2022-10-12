//
//  GetMoviesMiddleware.swift
//  Concrete Challenge
//
//  Created by Jonathan Pacheco on 11/10/22.
//

import Foundation
import Extensions
import Injection
import Redux
import Api

struct GetPopularMoviesMiddleware: Middleware {
    
    @Inject var connection: ConnectionInterface?
    
    func execute(state: AppState, action: Redux.Action) async -> Redux.Action? {
        do {
            guard action is Actions.LoadPopularMovieList,
                let data = try await connection?.connect(endpoint: Endpoints.GetPopularMovies()) else {
                return nil
            }
            let response = try Endpoints.GetPopularMovies.Response(from: data)
            return Actions.ReceivePopularMoviesList(movies: response.results)
        } catch let error {
            debugPrint(error)
            return Actions.ReceivePopularMoviesList(isError: true)
        }
    }
}
