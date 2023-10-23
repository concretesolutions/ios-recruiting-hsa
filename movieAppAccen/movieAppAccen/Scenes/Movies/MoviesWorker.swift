//
//  MoviesWorker.swift
//  movieAppAccen
//
//  Created by Orlando Velasco on 20-10-23.
//

import Foundation

class MoviesWorker {
    
    private let apiManager = APIManager()
    
    func fetchTopRatedMovies(completion: @escaping ([Movie]?, Error?) -> Void) {
        let endpoint = "/movie/top_rated"
        let parameters = ["language": "en-US", "page": "1"]
        
        apiManager.get(endpoint: endpoint, parameters: parameters) { data, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(MoviesResponse.self, from: data)
                    completion(response.results, nil)
                } catch {
                    completion(nil, error)
                }
            } else if let error = error {
                completion(nil, error)
            }
        }
    }
}
