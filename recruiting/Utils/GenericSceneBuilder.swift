//
//  GenericSceneBuilder.swift
//  recruiting
//
//  Created by Diego Vargas on 4/20/19.
//  Copyright © 2019 concrete. All rights reserved.
//

import Foundation
import SwiftyJSON

class GenericSceneBuilder {
    
    static func build (fileName: String) -> GenericScreenViewController {
        
        let name = NSStringFromClass(GenericScreenViewController.self).components(separatedBy: ".").last!
        let view = GenericScreenViewController(nibName: name, bundle: Bundle(for: self))
        let nav = Navigator(view: view)
        
        let presenter = GenericScreenPresenter(view: view, nav: nav)
        view.presenter = presenter
        
        let builder = ActionHandlerBuilder(presenter: presenter)
        presenter.actionHandlerBuilder = builder
        print(#function, presenter)
        
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let model = BaseRootTemplate(json: JSON(data))
                presenter.model = model
                print(#function, model, data)
            } catch {
                // handle error
            }
        }
        return view
    }
}
