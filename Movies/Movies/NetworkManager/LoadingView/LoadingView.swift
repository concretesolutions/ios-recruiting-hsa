//
//  LoadingView.swift
//  Movies
//
//  Created by Consultor on 12/17/18.
//  Copyright © 2018 Mavzapps. All rights reserved.
//

import UIKit
import Lottie

class LoadingView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    convenience init(){
        self.init(frame: UIScreen.main.bounds)
        loadAnimationView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    func loadAnimationView(){
        let animationView = LOTAnimationView(name: "movie_loading")
        addSubview(animationView)
        animationView.addConstraintsToCenter(scale: 0.5)
        animationView.contentMode = .scaleAspectFit
        animationView.loopAnimation = true
        animationView.play{ (finished) in
            // Do Something
        }
    }
    
    func hideAnimationView(){
        self.removeFromSuperview()
    }
}
