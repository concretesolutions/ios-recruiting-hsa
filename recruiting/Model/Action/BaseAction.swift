//
//  BaseAction.swift
//  recruiting
//
//  Created by Diego Vargas on 4/20/19.
//  Copyright © 2019 concrete. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol Action: JSONBuildeable {
    var id: String { get set }
    var type: String { get set }
    var label: String { get set }
}

class BaseAction: Action {
    var id: String
    var type: String
    var label: String

    required init(json: JSON) {
        self.id = json["id"].stringValue
        self.label = json["label"].stringValue
        self.type = json["type"].stringValue
    }
}
