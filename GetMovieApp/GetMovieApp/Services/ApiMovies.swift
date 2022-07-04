//
//  ApiMovies.swift
//  GetMovieApp
//
//  Created by Training on 03-07-22.
//

import Foundation
import Alamofire

class ApiMovies {
    
    //MARK: Propierties
    let urlPopularMovies: String = "https://api.themoviedb.org/3/movie/popular?api_key=dbc7d596f217d7a9d47c7db955eaa8a9&language=en-US"
    let page: Int = 1
    
    //MARK: Method get movies popular
    func getPolularMovie(complete : @escaping (_ status: ApiStatusEnum, _ response : MovieResponse?) -> ()) {
        
        AF.request("\(urlPopularMovies)").response { response in
    
            //Si la respues arroja error
            if response.error != nil {
                complete(.api_call_error, nil)
                return
            }

            //Si los datos son nulos entrara al else
            guard let data = response.data else {
                complete(.no_data, nil)
                print("Servicio no devuelve informacion")
                return

            }
            
            //sino continuara al Do
            do{

                let result = try JSONDecoder().decode(MovieResponse.self, from: data)
                print ("resultado")
                print(result)
                //si hay mas de un resultado
                if (result.total_results != 0) {
                    complete(.success, result)
                    return
                } else {
                    complete(.unsuccessfully,nil)
                    return
                }
                
            } catch let error{
                print(error)
                complete(.error_prosessing_content, nil)
                print("Existe Error: \(error)")
            }
        }
    }
    
    //MARK: Method get detail movie
    func getInfoMovie(movieId: Int, complete : @escaping (_ status: ApiStatusEnum, _ response : MovieInformacionResponse?) -> ()){

        let id: Int = movieId

        AF.request("https://api.themoviedb.org/3/movie/\(id)?api_key=dbc7d596f217d7a9d47c7db955eaa8a9&language=en-US").response { response in

            if response.error != nil {
                complete(.api_call_error, nil)
                return
            }

            guard let data = response.data else {
                complete(.no_data, nil)
                print("Servicio no arroja resultados")
                return
            }

            do{

                let result = try JSONDecoder().decode(MovieInformacionResponse.self, from: data)
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
                complete(.error_prosessing_content, nil)
                print("Existe Error: \(error)")
            }
        }
    }
}
