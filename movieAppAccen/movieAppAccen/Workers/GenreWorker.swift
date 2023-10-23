//
//  GenreWorker.swift
//  movieAppAccen
//
//  Created by Orlando Velasco on 21-10-23.
//

import Foundation

class GenreWorker {
    private let apiManager = APIManager()
    
    func fetchMovieGenres(completion: @escaping ([Genre]?, Error?) -> Void) {
        let endpoint = "/genre/movie/list"
        apiManager.get(endpoint: endpoint, parameters: [:]) { data, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(GenreResponse.self, from: data)
                    completion(response.genres, nil)
                } catch {
                    completion(nil, error)
                }
            } else if let error = error {
                completion(nil, error)
            }
        }
    }
}
