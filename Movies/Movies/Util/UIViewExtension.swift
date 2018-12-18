//
//  UIViewExtension.swift
//  Movies
//
//  Created by Consultor on 12/18/18.
//  Copyright © 2018 Mavzapps. All rights reserved.
//

import UIKit

extension UIView {
    func addConstraintsToCenter(scale: CGFloat = 1){
        self.translatesAutoresizingMaskIntoConstraints = false;
        let centerX = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superview, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let centerY = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superview, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superview, attribute: NSLayoutConstraint.Attribute.width, multiplier: scale, constant: 0)
        let height = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superview, attribute: NSLayoutConstraint.Attribute.height, multiplier: scale, constant: 0)
        self.superview?.addConstraints([centerX, centerY, width, height])
    }
}

