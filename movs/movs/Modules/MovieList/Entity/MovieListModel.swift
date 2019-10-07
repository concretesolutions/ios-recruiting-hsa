//
//  MovieListModel.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

class MovieListModel: Codable {
    
    var page: Int
    var totalResults: Int
    var totalPages: Int
    var results: [MovieModel]
    var categoryId: String?
    
    enum CodingKeys: String, CodingKey{
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
        case categoryId
    }
    
}
