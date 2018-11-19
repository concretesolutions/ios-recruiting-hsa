//
//  ErrorView.swift
//  ConcreteIOsRecruit
//
//  Created by Matías Contreras on 11/19/18.
//  Copyright © 2018 Matias Contreras. All rights reserved.
//

import UIKit
import Lottie

class ErrorView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        fromNib()
        
        let animationView = LOTAnimationView(name: "broken_stick_error")
        animationView.frame = self.frame
        animationView.frame.origin = CGPoint.zero
        self.addSubview(animationView)
        animationView.loopAnimation = true
        animationView.play()
    }
}
