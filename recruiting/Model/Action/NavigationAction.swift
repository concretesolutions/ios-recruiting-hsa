//
//  NavegationAction.swift
//  iOSTalk13122018
//
//  Created by Carlos David Rios Vertel on 12/13/18.
//  Copyright © 2018 Carlos David Rios Vertel. All rights reserved.
//

import Foundation
import SwiftyJSON

enum FlowType: String {
    case push = "push"
    case pop = "pop"
    case popRoot = "pop_root"
}

class NavigationAction: BaseAction {
    
    var flow: FlowType
    var route: String
    
    required init(json: JSON) {
        self.flow =  FlowType.init(rawValue: json["flow"].stringValue) ?? .popRoot
        self.route = json["route"].stringValue
        super.init(json: json)
    }
    
}
