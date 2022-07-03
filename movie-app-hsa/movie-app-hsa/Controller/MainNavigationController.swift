//
//  MainNavigationController.swift
//  movie-app-hsa
//
//  Created by training on 03-07-22.
//

import UIKit

class MainNavigationController: BaseNavigationController {

    @IBOutlet weak var titleNavigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleNavigationBar.backgroundColor = getUIColor(hex: "#f3cb5b ", alpha: 1)
        titleNavigationBar.isTranslucent = true
        titleNavigationBar.tintColor = .white
    }
}
