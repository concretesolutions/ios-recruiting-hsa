//
//  ApiEndpoints.swift
//  Movies
//
//  Created by Daniel Nunez on 04-03-21.
//

import Foundation

class API {

    static func moviesPath(with page: Int) -> String {
        let appConfiguration = AppConfiguration()
        let base = appConfiguration.apiBaseURL
        let key = appConfiguration.apiKey
        let path = "\(base)/movie/popular?api_key=\(key)&language=es-ES&page=\(page)"
        return path
    }

    static func genresPath() -> String {
        let appConfiguration = AppConfiguration()
        let base = appConfiguration.apiBaseURL
        let key = appConfiguration.apiKey
        let path = "\(base)/genre/movie/list?api_key=\(key)&language=es-ES"

        return path
    }

}
