//
//  File.swift
//  MillonariosFC
//
//  Created by Gabriel Colmenares on 11/1/17.
//  Copyright © 2017 Gabriel Colmenares. All rights reserved.
//

import UIKit

private var circularKey = false
private var shadowKey = false
private var roundedKey = 0
private var blurKey = false
private var firstColorKey = UIColor.white
private var secondColorKey = UIColor.white

extension UIView {
    @IBInspectable var rounded: Int {
        get { return roundedKey }
        set {
            roundedKey = newValue
            if roundedKey > 0 {
                self.layer.cornerRadius = CGFloat(roundedKey)
                self.clipsToBounds = true
            } else {
                self.clipsToBounds = false
            }
        }
    }

    @IBInspectable var circular: Bool {
        get { return circularKey }
        set {
            circularKey = newValue

            if circularKey {
                self.layer.cornerRadius = self.layer.frame.size.width/2
                self.clipsToBounds = true
            } else {
                self.clipsToBounds = false
            }
        }
    }

    var makeCircle: Bool {
        get {
            return self.makeCircle
        }
        set {
            if newValue {
                self.layer.cornerRadius = self.layer.frame.size.width/2
                self.clipsToBounds = true
            }
        }
    }

    @IBInspectable var shadow: Bool {
        get { return shadowKey }
        set {
            shadowKey = newValue

            if shadowKey {
                self.layer.masksToBounds = false
                self.layer.shadowColor = UIColor.init(red: 232/255, green: 228/255, blue: 251/255, alpha: 1).cgColor
                self.layer.shadowOpacity = 0.9
                self.layer.shadowOffset = CGSize(width: 5, height: 5)
                self.layer.shadowRadius = 10
            } else {
                self.layer.masksToBounds = true
            }
        }
    }

    func addBorder(color: CGColor, borderWitdh: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.borderColor = color
        self.layer.borderWidth = borderWitdh
    }

    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    }


    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            if shadow == false {
                self.layer.masksToBounds = true
            }
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    func addShadow(shadowColor: UIColor = .black,
                   shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
                   shadowOpacity: Float = 0.4,
                   shadowRadius: CGFloat = 3.0) {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }

    func roundedCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }

}

extension UIView {
    func EZRoundCorners(corners: UIRectCorner, radius: CGFloat) -> CAShapeLayer {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        return mask
    }

    func EZRoundCornersWithBorder(corners: UIRectCorner, radius: CGFloat, color: UIColor, width: CGFloat) -> CAShapeLayer {

        let mask = self.EZRoundCorners(corners: corners, radius: radius)

        // Add border
        let borderLayer = EZCALayer()
        borderLayer.path = mask.path // Reuse the Bezier path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = color.cgColor
        borderLayer.lineWidth = width
        borderLayer.frame = self.bounds
        self.layer.addSublayer(borderLayer)
        return borderLayer
    }

    func removeEZLayers () {
        for layer in self.layer.sublayers! where layer is EZCALayer {
            layer.removeFromSuperlayer()
        }
    }
}

class EZCALayer: CAShapeLayer {
}

extension UIButton {

    @IBInspectable var color: UIColor! {
        get { return tintColor }
        set {
            let image = imageView?.image?.withRenderingMode(.alwaysTemplate)
            setImage(image, for: isSelected ? .selected : .normal)
            tintColor = newValue
        }
    }
}

extension Error {
    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
}
