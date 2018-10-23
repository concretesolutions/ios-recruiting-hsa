//
//  Extensions.swift
//  TestProject
//
//  Created by Felipe S Vergara on 23-10-18.
//  Copyright © 2018 MyOwnCompany. All rights reserved.
//

import UIKit



extension UIButton{
    func favoriteType(show:Bool){
        self.setImage(show ? #imageLiteral(resourceName: "fav_on").withRenderingMode(.alwaysTemplate) : #imageLiteral(resourceName: "film-fav").withRenderingMode(.alwaysTemplate) , for: .normal)
        self.tintColor = UIColor(named: ColorName.DarkYellow.rawValue)
    }
}

extension UIView{
    func roundedCorners(cRadius:CGFloat){
        self.layer.cornerRadius = cRadius
        self.layer.masksToBounds = true
    }
}
