//
//  movieInformacionResponse.swift
//  GetMovieApp
//
//  Created by Training on 03-07-22.
//

import Foundation
class GenresMovie:Codable{
    //MARK: Propierties
    var name:String!

}

class MovieInformacionResponse: Codable {
    //MARK: Propierties
    var id : Int?
    var poster_path: String
    var backdrop_path: String
    var title: String!
    var release_date: String!
    var genres: [GenresMovie]!
    var overview: String!
    
}
