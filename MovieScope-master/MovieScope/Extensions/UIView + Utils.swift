//
//  UIView + Utils.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/3/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    
    func roundBorder(color: CGColor = UIColor.clear.cgColor, radius: CGFloat){
        self.layer.borderWidth = 1.0
        self.layer.borderColor = color
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func addLoadingAnimation(tintColor: UIColor?){
        let animHolder = AnimateImageHolder.init(frame: bounds)
        animHolder.tintColor = tintColor
        addSubview(animHolder)
        animHolder.infiniteAnimation()
    }
    
    func removeAnimateHolders(){
        
        subviews.forEach({
            if $0 is AnimateImageHolder{
                $0.removeFromSuperview()
            }
        })
    }
    
}
