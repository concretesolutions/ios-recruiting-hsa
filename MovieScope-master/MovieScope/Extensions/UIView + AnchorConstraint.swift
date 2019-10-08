//
//  UIView + AnchorConstraint.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/2/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    
    //Permite que una vista se expanda dependiendo del tamaño de su contenido
    func anchorToFitSize(size: CGSize){
        widthAnchor.constraint(greaterThanOrEqualToConstant: size.width).isActive = true
        heightAnchor.constraint(greaterThanOrEqualToConstant: size.height).isActive = true
    }
    
    func anchorCenter(centerX: NSLayoutXAxisAnchor?, centerXOffSet: CGFloat?, centerY: NSLayoutYAxisAnchor?, centerYOffSet: CGFloat?){
        
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let centerX = centerX{
            if let offSet = centerXOffSet{
                centerXAnchor.constraint(equalTo: centerX, constant: offSet).isActive = true
            }else{
                centerXAnchor.constraint(equalTo: centerX).isActive = true
            }
        }
        
        if let centerY = centerY{
            if let offSet = centerYOffSet{
                centerYAnchor.constraint(equalTo: centerY, constant: offSet).isActive = true
            }else{
                centerYAnchor.constraint(equalTo: centerY).isActive = true
            }
        }
    }
   
    func anchor(top: NSLayoutYAxisAnchor?,
                leading:NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                trailing: NSLayoutXAxisAnchor?,
                padding: UIEdgeInsets = .zero,
                size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top{
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading{
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let bottom = bottom{
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing{
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
}
