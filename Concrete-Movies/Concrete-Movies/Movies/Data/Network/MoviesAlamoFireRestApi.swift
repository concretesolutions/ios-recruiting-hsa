//
//  MoviesAlamoFireRestApi.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/28/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import Foundation
import Alamofire

class MoviesAlamoFireRestApi: MoviesRestApi{
    
    func popularMoviesEntity(completionHandler: @escaping (PopularMoviesResultEntity?, Error?) -> Void) {
        guard let url = URL(string: "\(NetworkConstants.baseUrl)\(NetworkConstants.popularMovies)\(NetworkConstants.apiKey)") else {
            completionHandler(nil, nil)
            return
        }
        Alamofire.request(url).response { response in
            guard let data = response.data else { return }
            do {
                let decoder = JSONDecoder()
                let movies = try decoder.decode(PopularMoviesResultEntity.self, from: data)
                completionHandler(movies, nil)
            } catch let error {
                print(error)
                completionHandler(nil, error)
            }
        }
    }
    
    func movieDetailEntity(movieId: String, completionHandler: @escaping (MovieDetailEntity?, Error?)->Void){
        guard let url = URL(string: "\(NetworkConstants.baseUrl)\(NetworkConstants.movieDetail)\(movieId)\(NetworkConstants.apiKey)") else {
            completionHandler(nil, nil)
            return
        }
        Alamofire.request(url).response { response in
            guard let data = response.data else { return }
            do {
                let decoder = JSONDecoder()
                let movie = try decoder.decode(MovieDetailEntity.self, from: data)
                completionHandler(movie, nil)
            } catch let error {
                print(error)
                completionHandler(nil, error)
            }
        }
    }
    
    func movieDetailEntity(completionHandler: @escaping (MovieDetailEntity?, Error?) -> Void) {
        guard let url = URL(string: "\(NetworkConstants.baseUrl)\(NetworkConstants.movieDetail)550\(NetworkConstants.apiKey)") else {
            completionHandler(nil, nil)
            return
        }
        Alamofire.request(url).response { response in
            guard let data = response.data else { return }
            do {
                let decoder = JSONDecoder()
                let movie = try decoder.decode(MovieDetailEntity.self, from: data)
                completionHandler(movie, nil)
            } catch let error {
                print(error)
                completionHandler(nil, error)
            }
        }
    }
}
