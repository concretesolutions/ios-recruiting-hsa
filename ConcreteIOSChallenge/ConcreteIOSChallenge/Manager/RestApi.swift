//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Accenture on 28-06-22.
//

import Foundation

struct Constants{
    
    static let API_KEY = "802d82af66e46aaffd70f97f87d023b0"
    static let baseURL = "https://api.themoviedb.org"
    static let YoutubeAPI_KEY = "AIzaSyAveFGaqQq2Mr0RZk3xZdVmS8VsJaG5MBc"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum APIError: Error {
    case failedTogetData
}

class RestApi{
    
    static let shared = RestApi()
    
    func getPopular(completion: @escaping (Result<[Movie], Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        
        //URLSESSION PERMITE CONSUMIR UN RECURSO DE UNA URL ESPECIFICA, EN ESTE CASO EL RECURSO ES UN JSON
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            //VIGILA QUE EL RECURSO(JSON) VENGA ALMACENADO EN LA VARIABLE DATA Y LO GUARDA EN LA CONSTANTE jsonData
            guard let jsonData = data, error == nil else {
                return
            }
            
            //JSONDecoder().decode permite parsear un json a una clase
            do {
                let results = try JSONDecoder().decode(ListMoviesResponse.self, from: jsonData)
                completion(.success(results.results))
            }
            catch{
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    //BUSCA INFORMACION DE LA PELICULA EN YOUTUBE
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void) {

        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "\(Constants.YoutubeBaseURL)q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else {return}

        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                print(results)
                completion(.success(results.items[0]))
            
            } catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
    
    



