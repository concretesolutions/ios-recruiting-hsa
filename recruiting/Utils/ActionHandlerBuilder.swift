//
//  ActionHandlerBuilder.swift
//  recruiting
//
//  Created by Diego Vargas on 4/20/19.
//  Copyright © 2019 concrete. All rights reserved.
//

import Foundation

final class ActionHandlerBuilder {
    
    weak var presenter: GenericScreenPresentation!
    
    init(presenter: GenericScreenPresentation) {
        self.presenter = presenter
    }
    
    func injectAction(inView: TemplateView) {
        guard let action = inView.data?.action else { return }        
        inView.handler = ActionHandlerFactory.handlerFor(data: action, presenter: self.presenter)
    }
}
