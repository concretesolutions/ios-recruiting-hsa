//
//  MovieGenreModel.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

class MovieGenreList: Codable{
    var genres: [MovieGenreModel]
}

class MovieGenreModel: Codable {
    
    var id: Int
    var name: String

}
