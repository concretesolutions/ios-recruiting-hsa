//
//  APiService.swift
//  ios-recruiting-hsa
//
//  Created by training on 01-07-22.
//

import Foundation
import Alamofire

class APIService{
    
//    let popularMovies: String = "https://api.themoviedb.org/3/movie/popular"
//    let apiKey : String = "b9d86c5962d09963a27e22e4949e2833"
//    let language: String = "en-US"
//    let page: Int = 1
    


    
    func getPolular(complete : @escaping (_ status: APIStatusType, _ response : MovieResponse?) -> ()) {
        let URLpopularMovies: String = URLBASE + MOVIE + POPULAR
    
        AF.request("\(URLpopularMovies)?api_key=\(APIKEY)&language=\(LANGUAJE)").response { response in
            
            if response.error != nil {
                complete(.api_call_error, nil)
                return
            }

            guard let data = response.data else {
                complete(.no_data, nil)
                print(response.data)
                print("Servicio no arroja resultados")
                return
            }
            
            do{
                let result = try JSONDecoder().decode(MovieResponse.self, from: data)
                print ("resultado")
                print(result)
                if (result.total_results != 0) {
                    complete(.success, result)
                    return
                } else {
                    complete(.unsuccessfully,nil)
                    return
                }
//                let controller: MovieViewController = MovieViewController()
//                controller.didGetMovies(result)
//
            } catch let error{
                print(error)
                complete(.error_processing_content, nil)
                print("Existe Error: \(error)")
            }
        }
    }
    
    func getDetail(movieId: Int, complete : @escaping (_ status: APIStatusType, _ response : DetalMovieResponse?) -> ()){
        
        let URLDetail: String = URLBASE + MOVIE
        
        let id: Int = movieId
    
        AF.request("\(URLDetail)/\(id)?api_key=\(APIKEY)&language=\(LANGUAJE)").response { response in
        
        if response.error != nil {
            complete(.api_call_error, nil)
            return
        }

        guard let data = response.data else {
            complete(.no_data, nil)
//            print(response.data)
            print("Servicio no arroja resultados")
            return
        }
        
        do{
            let result = try JSONDecoder().decode(DetalMovieResponse.self, from: data)
            print ("resultado")
            print(result)
            if (result.id != 0) {
                complete(.success, result)
                return
            } else {
                complete(.unsuccessfully,nil)
                return
            }

        } catch let error{
            
            complete(.error_processing_content, nil)
            print("Existe Error: \(error)")
        }
        }
    }
    
    func getSearch(query: String, complete : @escaping (_ status: APIStatusType, _ response : SearchResponse?) -> ()) {
        
        let URLDetail: String = URLBASE + SEARCH + MOVIE
        AF.request("\(URLDetail)/?api_key=\(APIKEY)&language=\(LANGUAJE)&query=\(query)&page=\(PAGE)&include_adult=false").response { response in
            
            if response.error != nil {
                complete(.api_call_error, nil)
                return
            }

            guard let data = response.data else {
                complete(.no_data, nil)
    //            print(response.data)
                print("Servicio no arroja resultados")
                return
            }
            
            do{
                let result = try JSONDecoder().decode(SearchResponse.self, from: data)
                print ("resultado")
                print(result)
                if (result.total_results != 0) {
                    complete(.success, result)
                    return
                } else {
                    complete(.unsuccessfully,nil)
                    return
                }

            } catch let error{
                
//                complete(.error_processing_content, nil)
                print("Existe Error: \(error)")
            }
            
            
            
            
            
            
            
            
        }
    }
            
      
    
    
    
}

    
    

