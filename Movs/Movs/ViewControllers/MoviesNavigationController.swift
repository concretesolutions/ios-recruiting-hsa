//
//  MoviesNavigationController.swift
//  Movs
//
//  Created by Jose Antonio Aravena on 9/3/19.
//  Copyright © 2019 Jose Antonio Aravena. All rights reserved.
//

import UIKit

class MoviesNavigationController: UINavigationController {



    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = .amarillo
        let navigationBar: UINavigationBar
        
        if UIScreen.main.bounds.size.height > 750 {
            navigationBar  = UINavigationBar(frame: CGRect(x: 0, y: 43, width: view.frame.size.width, height: 44))
        }
        else{
            navigationBar  = UINavigationBar(frame: CGRect(x: 0, y: 20, width: view.frame.size.width, height: 44))
        }
        
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        let play = UIBarButtonItem(title: "Play", style: .plain, target: self, action: nil)
        self.view.addSubview(navigationBar)

        
    
        let navigationItem = UINavigationItem(title: "hola")
        navigationItem.rightBarButtonItems = [add, play]
        navigationBar.setItems([navigationItem], animated: true)
        
        
       
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
  
}
