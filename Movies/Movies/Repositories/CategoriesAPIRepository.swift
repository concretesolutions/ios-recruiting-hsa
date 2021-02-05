//
//  CategoriesAPIRepository.swift
//  Movies
//
//  Created by Alfredo Luco on 05-02-21.
//

import Foundation
import UIKit

class CategoriesAPIRepository: CategoryStoreProtocol {
    
    //MARK: - Fetch Categories
    
    func fetchCategories(completion: @escaping FetchCategoriesCompletion) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let urlSession = URLSession(configuration: .default)
        do {
            let request = try ManagedURLRequest.fetchCategories([:]).asURLRequest()
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
                    let results = json["genres"] as? [[String : Any]] ?? []
                    let data2 = try JSONSerialization.data(withJSONObject: results, options: [])
                    let decoder = JSONDecoder()
                    let categories = try decoder.decode([Category].self, from: data2)
                    try appDelegate.persistentContainer.viewContext.save()
                    completion(.success(categories))
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
