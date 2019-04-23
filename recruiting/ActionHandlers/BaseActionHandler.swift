//
//  BaseActionHandler.swift
//  recruiting
//
//  Created by Diego Vargas on 4/20/19.
//  Copyright © 2019 concrete. All rights reserved.
//

import Foundation

protocol ActionHandler {
    var data: Action { get set }
    var presenter : GenericScreenPresentation! { get set }
    func run()
    
    init(data: Action, presenter: GenericScreenPresentation)
}

class BaseActionHandler: ActionHandler {
    var data: Action
    weak var presenter: GenericScreenPresentation!

    required init(data: Action, presenter: GenericScreenPresentation) {
        self.data = data
        self.presenter = presenter
    }
    
    func run() {        
    }
    
}
