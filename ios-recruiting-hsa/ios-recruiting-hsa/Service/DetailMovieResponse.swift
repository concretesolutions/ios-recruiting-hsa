//
//  DetailMovie.swift
//  ios-recruiting-hsa
//
//  Created by training on 01-07-22.
//

import Foundation
class GenereMovie:Codable{
    var name:String!

}

class DetalMovieResponse: Codable{
    var id : Int?
    var backdrop_path: String!
    var title: String!
    var release_date: String!
    var genres: [GenereMovie]!
    var overview: String!
    
    
    func YearDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: self.release_date) else {
            fatalError()
        }
        dateFormatter.dateFormat = "yyyy"
        let newDate = dateFormatter.string(from: date)
        return newDate
    }
    
    
    
    

}

