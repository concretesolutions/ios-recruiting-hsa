//
//  MovieListMapper.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

class RemoteMovieListMapper{
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> MovieListModel {
        guard response.statusCode == 200,
            let items = try? JSONDecoder().decode(MovieListModel.self, from: data) else {
                throw NetworkError.invalidData
        }
        return items
    }
}
