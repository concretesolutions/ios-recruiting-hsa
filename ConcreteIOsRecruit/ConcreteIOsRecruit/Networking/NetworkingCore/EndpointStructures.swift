//
//  Endpoints.swift
//  ConcreteIOsRecruit
//
//  Created by Matías Contreras Selman on 11/17/18.
//  Copyright © 2018 Matias Contreras. All rights reserved.
//

import Foundation
import Alamofire

struct DefaultServer: Server{
    let apiKey = "d4d63a063714027ed2ab411c2d7c81ed"
    let baseUrl = "https://api.themoviedb.org"
}

//full request example
//https://api.themoviedb.org/3/movie/popular?api_key=<<api_key>>&language=en-US&page=1

//we can list all the enpoints bellow, we can even separate them by type of object returned and we will be able to see all the endpoints properties just by looking at this file


struct PopularMoviesEndpoint: Endpoint{
    var server: Server = DefaultServer()
    var apiVersion: ApiVersion? = ApiVersion.v3
    var serverObject = ServerObject.movie
    var objectSorting : ObjectSorting? = ObjectSorting.popular
    var method = HTTPMethod.get
}

struct GenresEndpoint: Endpoint{
    var server: Server = DefaultServer()
    var apiVersion: ApiVersion? = ApiVersion.v3
    var serverObject = ServerObject.genre
    var objectSorting : ObjectSorting? = nil
    var method = HTTPMethod.get
}
