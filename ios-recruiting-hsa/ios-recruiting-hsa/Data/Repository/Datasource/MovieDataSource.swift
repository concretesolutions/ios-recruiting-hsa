//
//  MovieDataSource.swift
//  ios-recruiting-hsa
//
//  Created on 07-08-19.
//

protocol MovieDataSource {
    func fetchPopular(page: Int, completionHandler: @escaping (MovieResponseEntity?, ErrorEntity?) -> Void)
}
