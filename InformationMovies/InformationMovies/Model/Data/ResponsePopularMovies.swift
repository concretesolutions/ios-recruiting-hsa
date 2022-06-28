//
//  ResponsePopularMovies.swift
//  InformationMovies
//
//  Created by Cristian Bahamondes on 25-06-22.
//

import Foundation

struct ResponsePopularMovies:Decodable, ProtocolResponsePopularMovies {
    
    //MARK: Singleton
    static var shared = ResponsePopularMovies()
    
    //MARK: Properties
    var page:Int
    var results:[DataResult]
    var total_results:Int
    var total_pages:Int
    
    //MARK: Init
    init(page:Int = 0, results:[DataResult] = [], total_results:Int = 0, total_pages:Int = 0) {
        self.page = page
        self.results = results
        self.total_results = total_results
        self.total_pages = total_pages
    }
}
