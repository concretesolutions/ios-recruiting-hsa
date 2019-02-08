//
//  UIViewControllerExtension.swift
//  AccentureChallenge
//
//  Created by Jaime on 2/4/19.
//  Copyright © 2019 Jaime. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

extension UIViewController {
    
    // HIDE KEYBOARD
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true) //This will hide the keyboard
        
    }
}

extension UIViewController: NVActivityIndicatorViewable {
    
    func startLoading(message: String) {
        
        startAnimating(CGSize(width: 30, height: 30), message: message, messageFont: UIFont.boldSystemFont(ofSize: 13), type: NVActivityIndicatorType.ballSpinFadeLoader)
        
    }
    
    func stopLoading() {
        
        stopAnimating()
        
    }
}
