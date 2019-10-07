//
//  MovieDetailMapper.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

class RemoteMovieDetailMapper{
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> MovieDetailModel {
        guard response.statusCode == 200,
            let items = try? JSONDecoder().decode(MovieDetailModel.self, from: data) else {
                throw NetworkError.invalidData
        }
        return items
    }
}
