//
//  MoviesAPIManager.swift
//  ConcreteIOsRecruit
//
//  Created by Matías Contreras Selman on 11/18/18.
//  Copyright © 2018 Matias Contreras. All rights reserved.
//

import Foundation

struct MoviesAPIManager{
    //we can list all the other calls fot this type of object bellow and we will know which calls are being made within the app just by looking at this file
    
    func getPopularMovies(completition : @escaping([Movie]?, Error?) -> ()){
        let endpoint = PopularMoviesEndpoint()
        NetworkingManager().request(endpoint: endpoint) { (response: MoviesAPIResponse?, error) in
            completition(response?.results, error)
        }
    }
}
