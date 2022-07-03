//
//  getPopularResponse.swift
//  iOS-movieApp
//
//  Created by alvaro.concha on 01-07-22.
//

import Foundation


struct getPopularResponse : Decodable{
    let page : Int
    let results : [MovieResult]
    let total_pages : Int
    let total_results : Int    
}
