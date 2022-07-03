//
//  SecondaryNavigationController.swift
//  movie-app-hsa
//
//  Created by training on 03-07-22.
//

import UIKit

class SecondaryNavigationController: BaseNavigationController {

    
    @IBOutlet weak var titleSecondaryNavigationBar: UINavigationBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleSecondaryNavigationBar.backgroundColor = getUIColor(hex: "#f3cb5b ", alpha: 1)
        titleSecondaryNavigationBar.isTranslucent = true
        titleSecondaryNavigationBar.tintColor = .white
    }
}
