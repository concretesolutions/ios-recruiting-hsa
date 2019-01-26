//
//  GenreMovie.swift
//  MovieApp
//
//  Created by luis.a.rosas.arce on 25/01/19.
//  Copyright © 2019 luis.a.rosas.arce. All rights reserved.
//

import UIKit
import SwiftyJSON

class GenreMovie: NSObject {
    var genreID = ""
    var genreName = ""
    
    override init() {
        
    }
    
    convenience init(json : JSON) {
        self.init()
        genreID = String(describing: json["id"])
        genreName = String(describing: json["name"])
    }
    
}
