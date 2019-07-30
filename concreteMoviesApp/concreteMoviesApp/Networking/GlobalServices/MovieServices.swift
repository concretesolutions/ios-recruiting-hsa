//
//  MovieServices.swift
//  concreteMoviesApp
//
//  Created by Nebraska Melendez on 7/26/19.
//  Copyright © 2019 Nebraska Melendez. All rights reserved.
//

import Foundation

class MovieServices : ApiRest {
    
    let decoder = JSONDecoder()
    
    func getMovies(page: Int,
                   completion:@escaping(ResultTask<PagedList<MovieModel>>) -> Void){
        
        let endpoint =  self.serviceUrl.appending("page", value: "\(page)")
        
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
                
                let movies = try self.decoder.decode(PagedList<MovieModel>.self, from: data)
                completion(ResultTask.success(data: movies))
                
            }catch(let error){
                completion(ResultTask.error(error: error))
            }
        }
        
        dataTask.resume()
    }
    
}
