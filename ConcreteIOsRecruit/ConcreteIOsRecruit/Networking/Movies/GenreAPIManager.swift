//
//  GenreAPIManager.swift
//  ConcreteIOsRecruit
//
//  Created by Matías Contreras Selman on 11/20/18.
//  Copyright © 2018 Matias Contreras. All rights reserved.
//

import Foundation

struct GenreAPIManager{
    func getGenres(completition : @escaping([Genre]?, Error?) -> ()){
        let endpoint = GenresEndpoint()
        NetworkingManager().request(endpoint: endpoint) { (response: GenreAPIResponse?, error) in
            completition(response?.genres, error)
        }
    }
}
