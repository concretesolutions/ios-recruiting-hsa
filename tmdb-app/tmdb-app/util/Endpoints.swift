//
//  Endpoints.swift
//  tmdb-app
//
//  Created by training on 30-06-22.
//

import Foundation


struct Endpoints {
    private static let domain = "https://api.themoviedb.org/3"
    private static let apiKey = "?api_key=5512464eb1994e5370e753cb17dc050c"
    private static let defaultPopularMoviesFilters = "&language=es-CL&page=1"
    private static let defaultLanguageFilter = "&language=es-CL"
    static let popularMovies = Endpoints.domain + "/movie/popular" + Endpoints.apiKey + Endpoints.defaultPopularMoviesFilters
    static let imageBasePath = "https://image.tmdb.org/t/p/original"
    static let movieDetail = Endpoints.domain + "/movie/:movieId" + Endpoints.apiKey + Endpoints.defaultLanguageFilter
    
}

