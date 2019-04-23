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


    required init(json: JSON) {
        self.title = json["title"].stringValue
        self.subtitle = json["subtitle"].stringValue
        //self.subtitle = json["overview"].stringValue
        super.init(json: json)
    }
    
}
