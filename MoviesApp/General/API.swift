//
//  API.swift
//  MoviesApp
//
//  Created by Hector Morales on 2/27/21.
//

import Foundation

enum Path {
    case movies(page: Int)
    case genres
}

class API {
    static func getPath(for type: Path) -> String {
        let baseURL = "https://api.themoviedb.org/3/"
        let apiKey = "7ed2adb7ef241b314eda75ea7699cdc0"
        var path = ""

        switch type {
        case .movies(let page):
            path = "movie/popular?api_key=\(apiKey)&language=es-ES&page=\(page)"
        case .genres:
            path = "genre/movie/list?api_key=\(apiKey)&language=es-ES"
        }
        return baseURL + path
    }
}
