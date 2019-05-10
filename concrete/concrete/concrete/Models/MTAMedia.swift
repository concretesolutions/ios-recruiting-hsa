//
//  MTAMedia.swift
//  MovieApp
//
//  Created by Andres Ortiz on 4/17/19.
//  Copyright © 2019 Andres. All rights reserved.
//


import Foundation

struct Media: Codable{
    var id : Int64
    var results: [Video]
}
