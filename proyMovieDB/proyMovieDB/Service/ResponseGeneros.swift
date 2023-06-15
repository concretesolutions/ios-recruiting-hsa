//
//  ResponseGeneros.swift
//  proyMovieDB
//
//  Created by Tabata Céspedes Figueroa on 07-06-23.
//

import Foundation

class ResponseGeneros: Decodable {
    //MARK: Singleton
    static var shared = ResponseGeneros()

    var genres:[Generos]    
    init(genres: [Generos] = []) {
        self.genres = genres
    }
}

struct Generos: Decodable, Equatable {
    var id:Int
    var name:String
}
