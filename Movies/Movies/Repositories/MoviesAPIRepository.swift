//
//  MoviesAPIRepository.swift
//  Movies
//
//  Created by Alfredo Luco on 05-02-21.
//

import Foundation
import UIKit

class MoviesAPIRepository: MovieStoreProtocol {
    
    //MARK: - Fetch Popular Movies
    
    func fetchPopularMovies(completion: @escaping FetchPopularMoviesCompletion) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let urlSession = URLSession(configuration: .default)
        do {
            let request = try ManagedURLRequest.fetchMovies([:]).asURLRequest()
            let dataTask = urlSession.dataTask(with: request) { (data, response, error) in
                guard error == nil else {
                    completion(.failure(error!))
                    return
                }
                guard let dataValue = data else {
                    completion(.failure(NSError(domain: "Movies", code: 400, userInfo: [NSLocalizedDescriptionKey: "No data found"])))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let movies = try decoder.decode([Movie].self, from: dataValue)
                    try appDelegate.persistentContainer.viewContext.save()
                    completion(.success(movies))
                }catch let error {
                    completion(.failure(error))
                }
            }
            dataTask.resume()
        } catch let error {
            completion(.failure(error))
        }
        
    }
    
}
