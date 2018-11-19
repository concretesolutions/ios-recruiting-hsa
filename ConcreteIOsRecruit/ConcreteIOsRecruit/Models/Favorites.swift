//
//  Favorites.swift
//  ConcreteIOsRecruit
//
//  Created by Matías Contreras on 11/19/18.
//  Copyright © 2018 Matias Contreras. All rights reserved.
//

import Foundation

struct Favorites: Codable, Storable{
    var key: DataManager.StoringKey = .favorites
    var movies: [Movie] = [Movie]()
}
