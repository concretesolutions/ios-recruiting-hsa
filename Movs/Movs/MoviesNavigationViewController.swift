//
//  MoviesNavigationViewController.swift
//  Movs
//
//  Created by Jose Antonio Aravena on 9/3/19.
//  Copyright © 2019 Jose Antonio Aravena. All rights reserved.
//

import UIKit

class MoviesNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = UIColor.amarillo
        let navigationBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 50, width: self.view.frame.width, height: 44))
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        let play = UIBarButtonItem(title: "Play", style: .plain, target: self, action: nil)
        //let back = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: nil)
        self.view.addSubview(navigationBar)
        let vi = SwiftDisclosureIndicator.init()
        
        vi.color = UIColor.negro
        vi.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        vi.backgroundColor = UIColor.amarillo
        
        let backBarButtonItem = UIBarButtonItem.init(customView: vi)
 
    
        let navigationItem = UINavigationItem(title: "hola")
        navigationItem.rightBarButtonItems = [add, play]
        navigationItem.leftBarButtonItem = backBarButtonItem
        navigationBar.setItems([navigationItem], animated: false)
        
        
       
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
