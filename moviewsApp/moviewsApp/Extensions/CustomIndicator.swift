//
//  customIndicator.swift
//  moviewsApp
//
//  Created by carlos jaramillo on 8/30/18.
//  Copyright © 2018 carlos jaramillo. All rights reserved.
//

import UIKit
import ImageIO

class CustomIndicator: UIView {
    
    let indicatorImage : UIImageView = {
        let indicator = UIImageView()
        indicator.loadGif(name: "custom-indicator")
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect())
        
        self.frame = frame
        self.indicatorImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.indicatorImage)
        self.indicatorImage.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        self.indicatorImage.heightAnchor.constraint(equalToConstant: self.frame.height).isActive = true
        self.indicatorImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.indicatorImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
