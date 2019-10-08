//
//  AnimateImageHolder.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/13/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import UIKit

class AnimateImageHolder: UIImageView{
    
    init(frame: CGRect, imageToAnimate: UIImage? = .glassIcImage){
        super.init(frame: frame)
        contentMode = .scaleAspectFit
        image = imageToAnimate
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentMode = .scaleAspectFit
        image = .glassIcImage
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        guard let superView = superview else {
            return
        }
        let sizeAnchor = CGSize.init(width: 90.0, height: 90.0)
        anchorCenter(centerX: superView.centerXAnchor,
                     centerXOffSet: nil ,
                     centerY: superView.centerYAnchor,
                     centerYOffSet: -60.0)
        
        anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: sizeAnchor)
    }
    
    func infiniteAnimation(){
        let animOptions: UIView.KeyframeAnimationOptions = [.autoreverse, .repeat]
        UIView.animateKeyframes(withDuration: 0.2, delay: 0.0, options: animOptions, animations: {
            self.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
        }, completion: nil)
    }
    
}
