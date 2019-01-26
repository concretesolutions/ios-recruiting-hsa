//
//  BaseViewController.swift
//  MovieApp
//
//  Created by luis.a.rosas.arce on 22/01/19.
//  Copyright © 2019 luis.a.rosas.arce. All rights reserved.
//

import UIKit
import SVProgressHUD
class BaseViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor =  Tools.sharedInstance.getYelloAppColor()
        
    }
    
    func showLoader() {
        SVProgressHUD.setDefaultStyle(.light)
        SVProgressHUD.setRingRadius(2)
        SVProgressHUD.setBackgroundColor(UIColor.white)
        SVProgressHUD.setForegroundColor(Tools.sharedInstance.getYelloAppColor())
        SVProgressHUD.show()
    }
    
    func hideLoader() {
        SVProgressHUD.dismiss()
    }
    
}
