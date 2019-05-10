//
//  MTAVideo.swift
//  MovieApp
//
//  Created by Andres Ortiz on 4/17/19.
//  Copyright © 2019 Andres. All rights reserved.
//


import Foundation


struct Video: Codable {
    var site : String
    var id : String
    var size : Int64
    var iso_639_1 : String?
    var key : String
    var iso_3166_1 : String?
    var name : String
    var type : String
}
