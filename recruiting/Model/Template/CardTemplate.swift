//
//  CardTemplate.swift
//  recruiting
//
//  Created by Diego Vargas on 4/20/19.
//  Copyright © 2019 concrete. All rights reserved.
//

import Foundation
import SwiftyJSON

class CardTemplate: BaseTemplate {
    
    var title: String
    var subtitle: String
    var poster_path: String


    required init(json: JSON) {
        self.title = json["title"].stringValue
        self.subtitle = json["overview"].stringValue
        self.poster_path = json["poster_path"].stringValue
        super.init(json: json)
    }
    
}
