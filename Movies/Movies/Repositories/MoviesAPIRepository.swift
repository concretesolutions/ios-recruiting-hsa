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
        
        //Instancio el App delegate para obtener los registros desde core data y asi evitar duplicidad de datos
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //Inicializo el NSURLSession por default, dado que ephemeral y user no son obligatorios para el funcionamiento de la app.
        
        let urlSession = URLSession(configuration: .default)
        
        do {
            
            //Inicializo el request para obtener las peliculas populares
            
            let request = try ManagedURLRequest.fetchMovies([:]).asURLRequest()
            
            //Defino un data task en base al request
            
            let dataTask = urlSession.dataTask(with: request) { (data, response, error) in
                
                //Si ocurre un error devolver como resultado fallido
                
                guard error == nil else {
                    completion(.failure(error!))
                    return
                }
                
                //Obtener una data valida de lo contrario arrojar un error
                
                guard let dataValue = data else {
                    completion(.failure(NSError(domain: "Movies", code: 400, userInfo: [NSLocalizedDescriptionKey: "No data found"])))
                    return
                }
                do {
                    
                    //Obtener los registros internos del telefono para evitar duplicidad de datos
                    
                    let fetchRequest = NSFetchRequest<Movie>(entityName: "Movie")
                    let moviesFetched = Set(try appDelegate.persistentContainer.viewContext.fetch(fetchRequest))
                    
                    //Instanciar un seraializador de json acorde a los datos y castearlo como un diccionario
                    
                    let json = try JSONSerialization.jsonObject(with: dataValue, options: []) as? [String : Any] ?? [:]
                    
                    //Obtener solo los resultados nuevos
                    
                    let results = (json["results"] as? [[String : Any]] ?? []).filter { (dict) -> Bool in
                        return !moviesFetched.contains(where: { $0.id == (dict["id"] as? Int32 ?? 0) })
                    }
                    
                    //Obtener la data en base a estos nuevos datos
                    
                    let data2 = try JSONSerialization.data(withJSONObject: results, options: [])
                    
                    //Definir un decodificador de json
                    
                    let decoder = JSONDecoder()
                    
                    //Mapear resultados
                    
                    var movies = try decoder.decode([Movie].self, from: data2)
                    
                    //Agregar asimismo los resultados obtenidos desde core data
                    
                    movies.append(contentsOf: Array(moviesFetched))
                    
                    //Guardar registros
                    
                    appDelegate.saveContext()
                    
                    //Caso de exito
                    
                    completion(.success(movies))
                }catch let error {
                    print(error)
                    completion(.failure(error))
                }
            }
            
            //Ejecutar task
            
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
        
        //Instancio el App Delegate para guardar posteriormente los datos
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //Inicializo el NSURLSession por default, dado que ephemeral y user no son obligatorios para el funcionamiento de la app.
        
        let urlSession = URLSession(configuration: .default)
        
        do {
            
            //Inicializo el request para obtener una pelicula en particular
            
            let request = try ManagedURLRequest.fetchMovie(id, [:]).asURLRequest()
            
            //Defino el data task en base al request
            
            let dataTask = urlSession.dataTask(with: request) { (data, response, error) in
                
                //Si ocurre un error devolver como resultado fallido
                
                guard error == nil else {
                    completion(.failure(error!))
                    return
                }
                
                //Obtener una data valida de lo contrario arrojar un error
                
                guard let dataValue = data else {
                    completion(.failure(NSError(domain: "Movies", code: 400, userInfo: [NSLocalizedDescriptionKey: "No data found"])))
                    return
                }
                do {
                    
                    //Definir un decodificador de json
                    
                    let decoder = JSONDecoder()
                    
                    //Mapear la pelicula
                    
                    let movie = try decoder.decode(Movie.self, from: dataValue)
                    
                    //Guardar dato
                    
                    try appDelegate.persistentContainer.viewContext.save()
                    
                    //Caso de exito
                    
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
