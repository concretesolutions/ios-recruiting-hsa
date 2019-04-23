//
//  Navigator.swift
//  recruiting
//
//  Created by Diego Vargas on 4/20/19.
//  Copyright © 2019 concrete. All rights reserved.
//

import Foundation
import UIKit

protocol Navigation {
    var view: GenericScreenView? { get set }
    func pushView(route: String)
    func popToRoot()
    func pop() 
}

class Navigator: Navigation {
 
    weak var view: GenericScreenView?
    
    var vc: UIViewController? {
        get {
             return self.view as? UIViewController
        }
    }
    
    init(view: GenericScreenView?) {
        self.view = view
    }
    
    func pushView(route: String){
        let newView = GenericSceneBuilder.build(fileName: route)
        self.vc?.navigationController?.pushViewController(newView, animated: true)
        
    }
    
    func popToRoot() {
        self.vc?.navigationController?.popToRootViewController(animated: true)
    }
    
    func pop() {
        self.vc?.navigationController?.popViewController(animated: true)
    }
}
