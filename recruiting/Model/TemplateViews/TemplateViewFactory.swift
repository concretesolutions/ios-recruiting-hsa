//
//  TemplateViewFactory.swift
//  recruiting
//
//  Created by Diego Vargas on 4/20/19.
//  Copyright © 2019 concrete. All rights reserved.
//

import Foundation

class TemplateViewFactory {

    static func viewFor(data: Template) -> TemplateView? {
        
        let dic: [String: TemplateView.Type] = ["card": CardTemplateView.self]
     
        if let type = dic[data.id]{
            return type.view(withData:data)
        }
        
        return nil
    }
    
}

