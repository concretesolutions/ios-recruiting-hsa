//
//  UIViewUtilExtension.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/7/19.
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
    
}
