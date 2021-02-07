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
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Movie>(entityName: "Movie")
        
        do {
            let movies = try managedContext.fetch(fetchRequest)
            completion(.success(movies))
        } catch let error {
            print(error)
            completion(.failure(error))
        }
    }
    
    //MARK: - Search Popular Movies
    
    func searchPopularMovies(_ text: String, completion: @escaping SearchPopularMoviesCompletion) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Movie>(entityName: "Movie")
        fetchRequest.predicate = NSPredicate(format: "title CONTAINS[cd] %@", text)
        
        do {
            let movies = try managedContext.fetch(fetchRequest)
            completion(.success(movies))
        } catch let error {
            print(error)
            completion(.failure(error))
        }
    }
    
    //MARK: - Fetch Movie
    
    func fetchMovie(_ id: Int32, completion: @escaping FetchMovieCompletion) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Movie>(entityName: "Movie")
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)
        
        do {
            guard let movie = try managedContext.fetch(fetchRequest).first else {
                completion(.failure(NSError(domain: "Movies", code: 400, userInfo: [NSLocalizedDescriptionKey: "No Movie Found"])))
                return
            }
            completion(.success(movie))
        } catch let error {
            print(error)
            completion(.failure(error))
        }
    }
    
    //MARK: - Star Movie
    
    func starMovie(_ id: Int32, completion: @escaping StarMovieCompletion) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Movie>(entityName: "Movie")
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)
        
        do {
            guard let movie = try managedContext.fetch(fetchRequest).first else {
                completion(.failure(NSError(domain: "Movies", code: 400, userInfo: [NSLocalizedDescriptionKey: "No Movie Found"])))
                return
            }
            
            movie.starred = !movie.starred
            
            appDelegate.saveContext()
            
            completion(.success(true))
        } catch let error {
            print(error)
            completion(.failure(error))
        }
    }
    
    //MARK: - Fetch Starred Movies
    
    func fetchStarredMovies(_ completion: @escaping FetchStarredMoviesCompletion) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Movie>(entityName: "Movie")
        fetchRequest.predicate = NSPredicate(format: "starred == true")
        
        do {
            let movies = try managedContext.fetch(fetchRequest)
            completion(.success(movies))
        } catch let error {
            print(error)
            completion(.failure(error))
        }
    }
    
    //MARK: - Fetch Movie Years
    
    func fetchMovieYears(_ completion: @escaping FetchMovieYearsCompletion) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Movie>(entityName: "Movie")
        var years: Set<String> = []
        
        do {
            let movies = try managedContext.fetch(fetchRequest)
            var year: String = ""
            for m in movies {
                year = String(m.release_date?.split(separator: "-").first ?? "")
                if !years.contains(year) {
                    years.insert(year)
                }
            }
            completion(.success(Array(years)))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    //MARK: - Fetch Filtered Movies
    
    func fetchFilteredMovies(_ criteria: [Filter<String>], _ completion: @escaping FetchPopularMoviesCompletion) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Movie>(entityName: "Movie")
        
        var predicateStr: String = "starred == true"
        for i in criteria {
            if i.name == "Date" && (i.value ?? "") != "" {
                if predicateStr != "" {
                    predicateStr.append(" AND ")
                }
                predicateStr.append("release_date CONTAINS[cd] \(i.value ?? "")")
            }else if i.name == "Genre" && (i.value ?? "") != "" {
                let genreFetchRequest = NSFetchRequest<Category>(entityName: "Category")
                genreFetchRequest.predicate = NSPredicate(format: "name == %@", i.value ?? "")
                
                do {
                    guard let fetchedGenres = try managedContext.fetch(genreFetchRequest).first else {
                        completion(.failure(NSError(domain: "Movies", code: 400, userInfo: [NSLocalizedDescriptionKey: "No fetched Category"])))
                        return
                    }
                    if predicateStr != "" {
                        predicateStr.append(" AND ")
                    }
                    predicateStr.append(String(format: "ANY genre_ids == %i", fetchedGenres.id))
                } catch let error {
                    completion(.failure(error))
                }
            }
        }
        fetchRequest.predicate = NSPredicate(format: predicateStr)
        
        do {
            let movies = try managedContext.fetch(fetchRequest)
            completion(.success(movies))
        } catch let error {
            print(error)
            completion(.failure(error))
        }
        
    }
    
}
