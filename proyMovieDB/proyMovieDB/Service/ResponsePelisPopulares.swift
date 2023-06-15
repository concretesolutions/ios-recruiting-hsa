//
//  ResponsePelisPopulares.swift
//  proyMovieDB
//
//  Created by Tabata Céspedes Figueroa on 03-06-23.
//

import Foundation

class ResponsesPelisPopulares: Decodable {
    //MARK: Singleton
    static var shared = ResponsesPelisPopulares()
    
    var page:Int
    var results:[DataResult]
    var total_pages:Int
    var total_results:Int
    
    init(page: Int = 0, results: [DataResult] = [], total_pages: Int = 0, total_results: Int = 0) {
        self.page = page
        self.results = results
        self.total_pages = total_pages
        self.total_results = total_results
    }
    
    func getDataPelisPopulares() -> [DataResult] {
        
        var datos:[DataResult] = []
        results.forEach { data in
            datos.append(data)
        }
        return datos
    }
    
    func getDataPeliPopular() -> [DataResult] {
        return results
    }
}

struct DataResult:Decodable, Equatable{
    var adult:Bool
    var backdrop_path:String
    var genre_ids:[Int]
    var id:Int
    var original_language:String
    var original_title:String
    var overview:String
    var popularity:Float
    var poster_path:String
    var release_date:String
    var title:String
    var video:Bool
    var vote_average:Float
    var vote_count:Int
}
