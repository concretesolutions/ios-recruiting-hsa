//
//  CategoriesAPIRepository.swift
//  Movies
//
//  Created by Alfredo Luco on 05-02-21.
//

import Foundation
import UIKit
import CoreData

class CategoriesAPIRepository: CategoryStoreProtocol {
    
    //MARK: - Fetch Categories
    
    func fetchCategories(completion: @escaping FetchCategoriesCompletion) {
        
        //Instancio el app delegate para guardar internamente las categorias
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //Inicializo el NSURLSession en modo default
        
        let urlSession = URLSession(configuration: .default)
        do {
            
            //Defino un request para obtener las categorias
            
            let request = try ManagedURLRequest.fetchCategories([:]).asURLRequest()
            
            //Defino un data task en base al request
            
            let dataTask = urlSession.dataTask(with: request) { (data, response, error) in
                
                //Si ocurre un error devolver como resultado fallido

                guard error == nil else {
                    completion(.failure(error!))
                    return
                }
                
                //Obtener una data valida de lo contrario retornar error
                
                guard let dataValue = data else {
                    completion(.failure(NSError(domain: "Movies", code: 400, userInfo: [NSLocalizedDescriptionKey: "No data found"])))
                    return
                }
                do {
                    
                    //Serializar el json y obtener el label genres que es donde esta la data
                    
                    let json = try JSONSerialization.jsonObject(with: dataValue, options: []) as? [String : Any] ?? [:]
                    let results = json["genres"] as? [[String : Any]] ?? []
                    
                    //Obtener la data en base a los genres
                    
                    let data2 = try JSONSerialization.data(withJSONObject: results, options: [])
                    
                    //Inicializar un json decoder
                    
                    let decoder = JSONDecoder()
                    
                    //Mapear objetos
                    
                    let categories = try decoder.decode([Category].self, from: data2)
                    
                    //Evitar duplicados obteniendo las categorias
                    
                    let fetchRequest = NSFetchRequest<Category>(entityName: "Category")
                    let categoriesFetched = Set(try appDelegate.persistentContainer.viewContext.fetch(fetchRequest))
                    
                    for c in categories {
                        if !categoriesFetched.contains(where: { $0.id == c.id }) {
                            appDelegate.persistentContainer.viewContext.insert(c)
                        }
                    }
                    
                    //Caso de exito
                    
                    completion(.success(categories))
                }catch let error {
                    print(error)
                    completion(.failure(error))
                }
            }
            
            //Realizar task
            
            dataTask.resume()
        } catch let error {
            completion(.failure(error))
        }
        
    }
    
}
