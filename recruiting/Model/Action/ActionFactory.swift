//
//  ActionFactory.swift
//  recruiting
//
//  Created by Diego Vargas on 4/20/19.
//  Copyright © 2019 concrete. All rights reserved.
//

import Foundation
import SwiftyJSON


final class ActionFactory {
    
    static func actionFor(json: JSON) -> Action? {
        
        let dic: [String: Action.Type] = ["navigation": NavigationAction.self]
        
        let typeId = json["type"].stringValue
        
        if let type = dic[typeId]{
            return type.init(json: json)
        }
        
        return nil
    }
}
