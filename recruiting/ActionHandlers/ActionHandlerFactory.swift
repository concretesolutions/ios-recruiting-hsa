//
//  ActionHandlerFactory.swift
//  recruiting
//
//  Created by Diego Vargas on 4/20/19.
//  Copyright © 2019 concrete. All rights reserved.
//

import Foundation

final class ActionHandlerFactory {
    
    static func handlerFor(data: Action, presenter: GenericScreenPresentation) -> ActionHandler? {
        
        let dic: [String: ActionHandler.Type] = ["navigation": NavigationActionHandler.self]
        
        if let type = dic[data.type]{
            return type.init(data: data, presenter: presenter)
        }
        
        return nil
    }
}
