//
//  GenericScreenPresenter.swift
//  recruiting
//
//  Created by Diego Vargas on 4/20/19.
//  Copyright © 2019 concrete. All rights reserved.
//

import Foundation

protocol GenericScreenPresentation:class {
    
    var view: GenericScreenView! { get set }
    var navigator: Navigation { get set }
    var actionHandlerBuilder: ActionHandlerBuilder! { get set }

    func inflate()
}

class GenericScreenPresenter : GenericScreenPresentation {

    weak var view: GenericScreenView!
    var model: RootTemplate?
    var navigator: Navigation
    var actionHandlerBuilder: ActionHandlerBuilder!

    init(view: GenericScreenView, nav: Navigation) {
        self.view = view
        self.navigator = nav
    }
    
    func inflate() {
        guard let root = model else { return }
        let array = root.templates.compactMap { TemplateViewFactory.viewFor(data: $0)}
//        print(#function, root, array)
        self.view.add(views: array)
    }
}
