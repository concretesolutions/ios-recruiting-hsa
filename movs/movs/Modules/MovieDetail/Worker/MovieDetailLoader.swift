//
//  MovieDetailLoader.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

protocol MovieDetailLoader {
    typealias Result = Swift.Result<MovieDetailModel, Error>
    
    func fetchDetailData(movieId: Int, completion: @escaping(Result)->Void)
}
