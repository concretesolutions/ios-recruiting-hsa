//
//  BaseViewController.swift
//  MovieApp
//
//  Created by luis.a.rosas.arce on 22/01/19.
//  Copyright © 2019 luis.a.rosas.arce. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //#F6CE5B
        navigationController?.navigationBar.barTintColor =  UIColor(red: 246.0/255.0, green: 206.0/255.0, blue: 91.0/255.0, alpha: 1.0)
    }
    
}
