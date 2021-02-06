//
//  MoviesAPIRepository.swift
//  Movies
//
//  Created by Alfredo Luco on 05-02-21.
//

import Foundation
import UIKit
import CoreData

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
                    let json = try JSONSerialization.jsonObject(with: dataValue, options: []) as? [String : Any] ?? [:]
                    let results = json["results"] as? [[String : Any]] ?? []
                    let data2 = try JSONSerialization.data(withJSONObject: results, options: [])
                    let decoder = JSONDecoder()
                    let movies = try decoder.decode([Movie].self, from: data2)
                    
                    let fetchRequest = NSFetchRequest<Movie>(entityName: "Movie")
                    let moviesFetched = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
                    
                    for m in movies {
                        if !moviesFetched.contains(where: { $0.id == m.id }) {
                            appDelegate.persistentContainer.viewContext.insert(m)
                        }
                    }
                    completion(.success(movies))
                }catch let error {
                    print(error)
                    completion(.failure(error))
                }
            }
            dataTask.resume()
        } catch let error {
            completion(.failure(error))
        }
        
    }
    
    //MARK: - Search Popular Movies
    
    func searchPopularMovies(_ text: String, completion: @escaping SearchPopularMoviesCompletion) {
        //TODO: Si existiera un servicio de buscar, implementarlo. Para el ejercicio solo se solicita de manera local
        completion(.success([]))
    }
    
    //MARK: - Fetch Movie
    
    func fetchMovie(_ id: Int32, completion: @escaping FetchMovieCompletion) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let urlSession = URLSession(configuration: .default)
        do {
            let request = try ManagedURLRequest.fetchMovie(id, [:]).asURLRequest()
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
                    let movie = try decoder.decode(Movie.self, from: dataValue)
                    try appDelegate.persistentContainer.viewContext.save()
                    completion(.success(movie))
                }catch let error {
                    print(error)
                    completion(.failure(error))
                }
            }
            dataTask.resume()
        } catch let error {
            completion(.failure(error))
        }
    }
    
}
