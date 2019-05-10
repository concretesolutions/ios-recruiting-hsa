//
//  MTASearch.swift
//  MovieApp
//
//  Created by Andres Ortiz on 4/17/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import Foundation


struct Search: Decodable {
    var totalPages: Int64
    var results : [Movie]
    var totalResults: Int64
    var page: Int64
    var dates: DateRange?
}
