//
//  GenericScreenViewController.swift
//  recruiting
//
//  Created by Diego Vargas on 4/20/19.
//  Copyright © 2019 concrete. All rights reserved.
//

import UIKit

protocol GenericScreenView: class {
    func add(views:[TemplateView])
}

class GenericScreenViewController: UIViewController, GenericScreenView {

    var presenter: GenericScreenPresentation!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.inflate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func add(views:[TemplateView]) {
        for view in views {
            stackView.addArrangedSubview(view as! UIView)
            view.accept(self.presenter.actionHandlerBuilder)
        }
    }

}
