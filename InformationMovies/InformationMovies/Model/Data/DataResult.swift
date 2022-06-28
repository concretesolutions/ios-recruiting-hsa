//
//  DataResult.swift
//  InformationMovies
//
//  Created by Cristian Bahamondes on 25-06-22.
//

import Foundation

struct DataResult:Decodable {
    
    //MARK: Properties
    var poster_path:String
    var adult:Bool
    var overview:String
    var release_date:String
    var genre_ids:[Int]
    var id:Int
    var original_title:String
    var original_language:String
    var title:String
    var backdrop_path:String
    var popularity:Float
    var vote_count:Int
    var video:Bool
    var vote_average:Float
    
}
