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
    
}
