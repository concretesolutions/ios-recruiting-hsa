//
//  UIColor + Utils.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/4/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    
    class func ratingColor(ratingApproval: Float) -> UIColor {
        return UIColor(hue: CGFloat(ratingApproval / 3), saturation: 0.7, brightness: 1.0, alpha: 1.0)
    }
    
}
