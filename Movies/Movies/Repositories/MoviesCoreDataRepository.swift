//
//  MoviesCoreDataRepository.swift
//  Movies
//
//  Created by Alfredo Luco on 05-02-21.
//

import Foundation
import CoreData
import UIKit

class MoviesCoreDataRepository: MovieStoreProtocol {
    
    //MARK: - Fetch Popular Movies
    
    func fetchPopularMovies(completion: @escaping FetchPopularMoviesCompletion) {
        
        //Instancio el contexto de core data
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Realizo un request de peliculas (sin restricciones)
        
        let fetchRequest = NSFetchRequest<Movie>(entityName: "Movie")
        
        do {
            
            //Obtengo las peliculas
            
            let movies = try managedContext.fetch(fetchRequest)
            
            //Caso de éxito
            
            completion(.success(movies))
        } catch let error {
            print(error)
            completion(.failure(error))
        }
    }
    
    //MARK: - Search Popular Movies
    
    func searchPopularMovies(_ text: String, completion: @escaping SearchPopularMoviesCompletion) {
        
        //Instancio el contexto de core data
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Busco peliculas segun su titulo
        
        let fetchRequest = NSFetchRequest<Movie>(entityName: "Movie")
        fetchRequest.predicate = NSPredicate(format: "title CONTAINS[cd] %@", text)
        
        do {
            
            //Obtengo las peliculas
            
            let movies = try managedContext.fetch(fetchRequest)
            
            //Caso de éxito
            
            completion(.success(movies))
        } catch let error {
            print(error)
            completion(.failure(error))
        }
    }
    
    //MARK: - Fetch Movie
    
    func fetchMovie(_ id: Int32, completion: @escaping FetchMovieCompletion) {
        
        //Instancio el contexto de core data
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Obtengo la pelicula acorde a su id
        
        let fetchRequest = NSFetchRequest<Movie>(entityName: "Movie")
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)
        
        do {
            
            //Obtengo el primer elemento del resultado de busqueda, en caso contrario arrojo error
            
            guard let movie = try managedContext.fetch(fetchRequest).first else {
                completion(.failure(NSError(domain: "Movies", code: 400, userInfo: [NSLocalizedDescriptionKey: "No Movie Found"])))
                return
            }
            
            //Caso de exito
            
            completion(.success(movie))
        } catch let error {
            print(error)
            completion(.failure(error))
        }
    }
    
    //MARK: - Star Movie
    
    func starMovie(_ id: Int32, completion: @escaping StarMovieCompletion) {
        
        //Inicializo el contexto de core data
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Busco la pelicula segun su id
        
        let fetchRequest = NSFetchRequest<Movie>(entityName: "Movie")
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)
        
        do {
            
            //Encuentro la pelicula, de otra forma arrojo error
            
            guard let movie = try managedContext.fetch(fetchRequest).first else {
                completion(.failure(NSError(domain: "Movies", code: 400, userInfo: [NSLocalizedDescriptionKey: "No Movie Found"])))
                return
            }
            
            //Cambio el estado si esta o no en favoritos
            
            movie.starred = !movie.starred
            
            //Aplico los cambios
            
            appDelegate.saveContext()
            
            //Caso de exito
            
            completion(.success(true))
        } catch let error {
            print(error)
            completion(.failure(error))
        }
    }
    
    //MARK: - Fetch Starred Movies
    
    func fetchStarredMovies(_ completion: @escaping FetchStarredMoviesCompletion) {
        
        //Inicializo el contexto de core data
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Busco las peliculas donde han sido catalogadas como favoritos
        
        let fetchRequest = NSFetchRequest<Movie>(entityName: "Movie")
        fetchRequest.predicate = NSPredicate(format: "starred == true")
        
        do {
            
            //Obtengo las peliculas
            
            let movies = try managedContext.fetch(fetchRequest)
            
            //Caso de exito
            
            completion(.success(movies))
        } catch let error {
            print(error)
            completion(.failure(error))
        }
    }
    
    //MARK: - Fetch Movie Years
    
    func fetchMovieYears(_ completion: @escaping FetchMovieYearsCompletion) {
        
        //Instancio el contexto de core data
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Realizo un request de todas las peliculas
        
        let fetchRequest = NSFetchRequest<Movie>(entityName: "Movie")
        
        // Inicializo un set de los años
        
        var years: Set<String> = []
        
        do {
            
            // Obtengo las peliculas
            
            let movies = try managedContext.fetch(fetchRequest)
            
            // Variable de año como variable auxiliar
            
            var year: String = ""
            
            //Por cada pelicula verifico si el año esta en el set. Si no lo esta lo agrego.
            
            for m in movies {
                year = String(m.release_date?.split(separator: "-").first ?? "")
                if !years.contains(year) {
                    years.insert(year)
                }
            }
            
            //Caso de exito: Devuelvo el set en forma de arreglo
            
            completion(.success(Array(years)))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    //MARK: - Fetch Filtered Movies
    
    func fetchFilteredMovies(_ criteria: [Filter<String>], _ completion: @escaping FetchPopularMoviesCompletion) {
        
        //Instancio el context de core data
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Inicializo un request de movies
        
        let fetchRequest = NSFetchRequest<Movie>(entityName: "Movie")
        
        //Iniciar el predicado partiendo por los favoritos
        
        var predicateStr: String = "starred == true"
        for i in criteria {
            
            //Si esta filtrando en una fecha agregar esa restriccion
            
            if i.name == "Date" && (i.value ?? "") != "" {
                if predicateStr != "" {
                    predicateStr.append(" AND ")
                }
                predicateStr.append("release_date CONTAINS[cd] \(i.value ?? "")")
            } // Si esta filtrando por Genero Agregar esa restriccion
            else if i.name == "Genre" && (i.value ?? "") != "" {
                
                //Obtener los generos haciendo match del nombre del genero (ej: Aventura)
                
                let genreFetchRequest = NSFetchRequest<Category>(entityName: "Category")
                genreFetchRequest.predicate = NSPredicate(format: "name == %@", i.value ?? "")
                
                do {
                    
                    //Obtener genero
                    
                    guard let fetchedGenres = try managedContext.fetch(genreFetchRequest).first else {
                        completion(.failure(NSError(domain: "Movies", code: 400, userInfo: [NSLocalizedDescriptionKey: "No fetched Category"])))
                        return
                    }
                    
                    //Agregar al predicado
                    
                    if predicateStr != "" {
                        predicateStr.append(" AND ")
                    }
                    predicateStr.append(String(format: "ANY genre_ids == %i", fetchedGenres.id))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
        
        //Instanciar el predicado en base a las restricciones
        
        fetchRequest.predicate = NSPredicate(format: predicateStr)
        
        do {
            
            //Obtener peliculas y devolverlas como caso de exito
            
            let movies = try managedContext.fetch(fetchRequest)
            completion(.success(movies))
        } catch let error {
            print(error)
            completion(.failure(error))
        }
        
    }
    
}
