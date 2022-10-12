//
//  GetGenresMiddleware.swift
//  Concrete Challenge
//
//  Created by Jonathan Pacheco on 11/10/22.
//

import Foundation
import Extensions
import Injection
import Redux
import Api

struct GetGenresMiddleware: Middleware {
    
    @Inject var connection: ConnectionInterface?
    
    func execute(state: any State, action: Redux.Action) async -> Redux.Action? {
        do {
            guard action is Actions.LoadGenreList,
                  let data = try await connection?.connect(endpoint: Endpoints.GetMoviesGenres()) else {
                return nil
            }
            let response = try Endpoints.GetMoviesGenres.Response(from: data)
            return Actions.ReceiveGenreList(genres: response.genres)
        } catch let error {
            debugPrint(error)
            return nil
        }
    }
}
