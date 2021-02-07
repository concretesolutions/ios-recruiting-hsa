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
                    
                    let fetchRequest = NSFetchRequest<Movie>(entityName: "Movie")
                    let moviesFetched = Set(try appDelegate.persistentContainer.viewContext.fetch(fetchRequest))
                    
                    let json = try JSONSerialization.jsonObject(with: dataValue, options: []) as? [String : Any] ?? [:]
                    let results = (json["results"] as? [[String : Any]] ?? []).filter { (dict) -> Bool in
                        return !moviesFetched.contains(where: { $0.id == (dict["id"] as? Int32 ?? 0) })
                    }
                    let data2 = try JSONSerialization.data(withJSONObject: results, options: [])
                    let decoder = JSONDecoder()
                    var movies = try decoder.decode([Movie].self, from: data2)
                    
                    movies.append(contentsOf: Array(moviesFetched))
                    
                    appDelegate.saveContext()
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
    
    //MARK: - Star Movie
    
    //TODO: Si por alguna razon la API soportara un usuario se puede utilizar un servicio web
    
    func starMovie(_ id: Int32, completion: @escaping StarMovieCompletion) {
        completion(.success(true))
    }
    
    //MARK: - Fetch Starred Movies
    
    //TODO: Si por alguna razon la API soportara un usuario se puede utilizar un servicio web
    
    func fetchStarredMovies(_ completion: @escaping FetchStarredMoviesCompletion) {
        completion(.success([]))
    }
    
    //MARK: - Fetch Movie Years
    
    //TODO: No existe un servicio en la API
    
    func fetchMovieYears(_ completion: @escaping FetchMovieYearsCompletion) {
        completion(.success([]))
    }
    
    //MARK: - Fetch Filtered Movies
    
    //TODO: No existe un servicio en la API
    
    func fetchFilteredMovies(_ criteria: [Filter<String>], _ completion: @escaping FetchPopularMoviesCompletion) {
        completion(.success([]))
    }
    
}
