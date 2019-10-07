//
//  FavoriteListLoader.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

class GenreListLoader{
    typealias Result = Swift.Result<[MovieGenreModel], Error>
    
    private let enviroment: Enviroment
    private let client: HTTPClient
    
    init(enviroment: Enviroment = Enviroment(), client: HTTPClient) {
        self.enviroment = enviroment
        self.client = client
    }
    
    func getGenreList(completion: @escaping (Result)->Void){
        let request: FavoriteMoviesServices = .genreList
        executeRequest(with: request, completion: completion)
    }
    
    private func executeRequest(with service: ServiceRequest, completion: @escaping (Result)->Void){
        
        let request = URLRequest.init(service: service, enviroment: enviroment)
        client.executeRequest(request: request) { [weak self] result in
            guard self != nil else { return }
            switch result{
            case let .success(data, response):
                completion(GenreListLoader.map(data, from: response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        do {
            let movieGenres = try GenreListMapper.map(data, from: response)
            return .success(movieGenres.genres)
            
        } catch {
            return .failure(error)
        }
    }
    
}
