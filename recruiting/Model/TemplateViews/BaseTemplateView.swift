//
//  BaseTemplateView.swift
//  recruiting
//
//  Created by Diego Vargas on 4/20/19.
//  Copyright © 2019 concrete. All rights reserved.
//

import Foundation
import UIKit

protocol TemplateView:class {
    
    var data: Template? { get set }
    var handler: ActionHandler? { get set }
    
    func updateUI()
    func accept(_ builder: ActionHandlerBuilder)

    static func view(withData:Template) -> TemplateView
    
}

class BaseTemplateView: UIView, TemplateView {

    var data: Template?
    var handler: ActionHandler?

    func updateUI() {}
    
    static func view(withData:Template) -> TemplateView {
        let name = NSStringFromClass(self).components(separatedBy: ".").last!
        let view = Bundle(for: self).loadNibNamed(name, owner: self, options: nil)?.last as! TemplateView
        view.data = withData
        view.updateUI()
        return view
    }

    func accept(_ builder: ActionHandlerBuilder) {
        builder.injectAction(inView: self)
    }
}
