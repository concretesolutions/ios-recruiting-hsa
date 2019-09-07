//
//  SwiftDisclosureIndicator.swift
//  Movs
//
//  Created by Jose Antonio Aravena on 9/4/19.
//  Copyright © 2019 Jose Antonio Aravena. All rights reserved.
//

import UIKit

class SwiftDisclosureIndicator: UIView {
    var color = UIColor.red
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        let x = self.bounds.maxX - 2
        let y = self.bounds.midY
        let R = CGFloat(4.5)
        context!.move(to: CGPoint(x: x - R, y: y - R))
        context!.addLine(to: CGPoint(x: x, y: y))
        context!.addLine(to:CGPoint(x: x - R, y: y + R))
        context!.setLineCap(CGLineCap.square)
        context!.setLineJoin(CGLineJoin.miter)
        context!.setLineWidth(2)
        color.setStroke()
        context!.strokePath()
    }
    
}
