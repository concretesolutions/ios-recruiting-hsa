//
//  Endpoints.swift
//  ios-recruiting-hsa
//
//  Created on 07-08-19.
//

enum Endpoints {
    enum Movies: String {
        case popular = "%@/movie/popular?page=%d&%@"
        case movieDetail = "%@/movie/%d?%@"
    }
}
