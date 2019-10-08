//
//  Constants.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/2/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation


//Contiene los posibles servidores a los que se conectara la app, util en el caso de que existan servidores de test y producción o algun servidor externo para mostrar info
enum Host: String{
    case moviedb = "https://api.themoviedb.org/3/"
    case moviedbImages = "https://image.tmdb.org/t/p/"
    case youtubeImages = "http://img.youtube.com/vi/"
}



//Escalable en el caso que se deeseen añadir nuevas apiKeys al proyecto
enum ExternalApiKeys: String{
    case moviedb = "244c747c2d4354bf8a752d4794112f53"
}

// No me convence el nombre pero es un parametro universal para todos los request de la app.
enum QueryApiKey: String{
    case api_key = "api_key"
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json;charset=utf-8"
}

enum SupportedImageSizes: String{
    case w300
    case w780
    case w1280
    case original
}
