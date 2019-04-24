//
//  BaseTemplateView.swift
//  recruiting
//
//  Created by Diego Vargas on 4/20/19.
//  Copyright © 2019 concrete. All rights reserved.
//

import Foundation
import SwiftyJSON


protocol RootTemplate {
    var templates: [Template] { get set }
}

protocol Template: JSONBuildeable {
    var id: String { get set }
    var action: Action? { get set }
}

class BaseTemplate: Template {
    var id: String
    var action: Action?

    required init(json: JSON) {
        self.id = "card"
        let array = [
                "id": "push_to_any_view",
                "type": "navigation",
                "route": "movie",
                "flow": "push"
            ]
        let action = JSON(arrayLiteral: array)
        self.action = ActionFactory.actionFor(json: action[0])
    }
}


class BaseRootTemplate: RootTemplate, JSONBuildeable {

    var templates: [Template]

    required init(json: JSON) {
        self.templates = json["results"].arrayValue.compactMap { TemplateFactory.templateFor(json: $0, typeId: "card") }
   }
}

class BaseMovieTemplate: RootTemplate, JSONBuildeable {
    var templates: [Template]
    
    required init(json: JSON) {
        self.templates = json["results"].arrayValue.compactMap { TemplateFactory.templateFor(json: $0, typeId: "movie") }
    }
}


