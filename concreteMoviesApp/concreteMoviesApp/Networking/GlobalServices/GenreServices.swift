//
//  GenreServices.swift
//  concreteMoviesApp
//
//  Created by Nebraska Melendez on 7/27/19.
//  Copyright © 2019 Nebraska Melendez. All rights reserved.
//

import Foundation


class GenreServices : ApiRest {
    
    let decoder = JSONDecoder()
    
    func getGenre(completion:@escaping(ResultTask<GenresList<GenreModel>>) -> Void){
        
        let endpoint =  self.serviceUrl
        
        let dataTask = URLSession.shared.dataTask(with: endpoint) { (data, _, error) in
            
            if let error = error {
                // Handle Error
                completion(ResultTask.error(error: error))
                return
            }
            
            guard let data = data else {
                // Handle Empty Data
                return
            }
            // Handle Decode Data into Model
            do{
                
                let genres = try self.decoder.decode(GenresList<GenreModel>.self, from: data)
                completion(ResultTask.success(data: genres))
                
            }catch(let error){
                completion(ResultTask.error(error: error))
            }
        }
        
        dataTask.resume()
    }
    
}
