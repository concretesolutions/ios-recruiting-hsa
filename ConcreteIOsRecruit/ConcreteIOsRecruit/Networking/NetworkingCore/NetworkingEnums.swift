//
//  NetworkingEnums.swift
//  ConcreteIOsRecruit
//
//  Created by Matías Contreras Selman on 11/18/18.
//  Copyright © 2018 Matias Contreras. All rights reserved.
//

import Foundation

enum ApiVersion: Int{
    case v1 = 1
    case v2 = 2
    case v3 = 3
}

enum ServerObject: String{
    case movie
    case genre = "genre/movie/list"
    //we can add more endpoint objects if needed
}

enum ObjectSorting: String{
    case popular = "popular"
    case topRated = "toprated"
    case upcoming = "upcoming"
    // we can add more sorting or detail strings for the endpoints...
    // it will all depend on the URL structure
}
