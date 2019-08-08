//
//  MovieResponseModel.swift
//  ios-recruiting-hsa
//
//  Created on 07-08-19.
//

struct MovieResponseModel {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [MovieModel]
}
