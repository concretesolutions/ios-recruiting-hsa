//
//  MovieRepository.swift
//  ios-recruiting-hsa
//
//  Created on 07-08-19.
//

protocol MovieRepository {
    func fetchPopular(page: Int, completionHandler: @escaping (MovieResponseModel?, ErrorModel?) -> Void)
}
