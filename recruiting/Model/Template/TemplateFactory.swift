//
//  TemplateFactory.swift
//  recruiting
//
//  Created by Diego Vargas on 4/20/19.
//  Copyright © 2019 concrete. All rights reserved.
//

import Foundation
import SwiftyJSON


final class TemplateFactory {
    
    static func templateFor(json: JSON, typeId: String) -> Template? {
        
        let dic: [String: Template.Type] = [typeId: CardTemplate.self]
//        let typeId = json["id"].stringValue
//        print(#function, dic, json)
        if let type = dic[typeId]{
//            print(#function, typeId)
            return type.init(json: json)
        }
        return nil
    }
}

