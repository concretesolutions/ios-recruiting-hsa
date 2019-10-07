//
//  RemoteMovieDetailLoader.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

class RemoteMovieDetailLoader: MovieDetailLoader{
    private let enviroment: Enviroment
    private let client: HTTPClient
    
    typealias Result = MovieDetailLoader.Result
    
    init(enviroment: Enviroment = Enviroment(), client: HTTPClient) {
        self.enviroment = enviroment
        self.client = client
    }
    
    func fetchDetailData(movieId: Int, completion: @escaping (Result) -> Void) {
        let detailService: MovieDetailServices = .getDetail(movieId: movieId)
        executeRequest(with: detailService, completion: completion)
    }
    
    private func executeRequest(with service: ServiceRequest, completion: @escaping (Result)->Void){
        
        let request = URLRequest.init(service: service, enviroment: enviroment)
        client.executeRequest(request: request) { [weak self] result in
            guard self != nil else { return }
            switch result{
            case let .success(data, response):
                completion(RemoteMovieDetailLoader.map(data, from: response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private static func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        do {
            let movieDetail = try RemoteMovieDetailMapper.map(data, from: response)
            return .success(movieDetail)
        } catch {
            return .failure(error)
        }
    }
}
