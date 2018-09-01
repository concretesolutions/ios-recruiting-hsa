//
//  genre.swift
//  moviewsApp
//
//  Created by carlos jaramillo on 9/1/18.
//  Copyright © 2018 carlos jaramillo. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Genre {
    var id : Int?
    var name : String?
    
    static var genres : [Genre] = []
    
    init(jsonData : JSON) {
        self.name = jsonData["name"].exists() ? jsonData["name"].string : ""
        self.id = jsonData["id"].exists() ? jsonData["id"].int : 0
    }
}
