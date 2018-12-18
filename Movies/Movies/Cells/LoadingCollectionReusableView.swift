//
//  LoadingCollectionReusableView.swift
//  Movies
//
//  Created by Consultor on 12/17/18.
//  Copyright © 2018 Mavzapps. All rights reserved.
//

import UIKit
import Lottie

class LoadingCollectionReusableView: UICollectionReusableView {
        
    @IBOutlet weak var contentView: UIView!
    
    override func awakeFromNib() {
        let animationView = LOTAnimationView(name: "movie_loading")
        contentView.addSubview(animationView)
        animationView.addConstraintsToCenter(scale: 0.5)
        animationView.contentMode = .scaleAspectFit
        animationView.loopAnimation = true
        animationView.play{ (finished) in
            // Do Something
        }
    }
}
