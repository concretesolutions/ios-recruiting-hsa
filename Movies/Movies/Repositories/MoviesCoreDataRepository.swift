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
    
}
