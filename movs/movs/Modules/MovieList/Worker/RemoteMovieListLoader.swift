//
//  RemoteMovieListLoader.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

class RemoteMovieListLoader: MovieListLoader{
    
    private let enviroment: Enviroment
    private let client: HTTPClient
    
    typealias Result = MovieListLoader.Result
    
    init(enviroment: Enviroment = Enviroment(), client: HTTPClient) {
        self.enviroment = enviroment
        self.client = client
    }
    
    func getMovieList(page: Int, completion: @escaping (Result) -> Void) {
        let request: HomeMovieServices = .popular(page: page)
        executeRequest(with: request, completion: completion)
    }
    
    func searchMovie(searchQuery: String, page: Int, completion: @escaping (Result) -> Void) {
        let request: HomeMovieServices = .search(query: searchQuery, page: page)
        executeRequest(with: request, completion: completion)
    }
    
    private func executeRequest(with service: ServiceRequest, completion: @escaping (Result)->Void){
        
        let request = URLRequest.init(service: service, enviroment: enviroment)
        client.executeRequest(request: request) { [weak self] result in
            guard self != nil else { return }
            switch result{
            case let .success(data, response):
                completion(RemoteMovieListLoader.map(data, from: response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        do {
            let movieList = try RemoteMovieListMapper.map(data, from: response)
            
            return .success(movieList)
            
        } catch {
            return .failure(error)
        }
    }
    
}
