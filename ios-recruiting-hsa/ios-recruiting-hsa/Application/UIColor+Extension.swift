//
//  UIColor+Extension.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/28/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {

    // 45 48 67
    static var banner: UIColor? { return UIColor(named: "Banner") }

    // 236 208 125
    static var app: UIColor? { return UIColor(named: "App") }

    // 208 153 61
    static var darkApp: UIColor? { return UIColor(named: "DarkApp") }

    // 216 216 216
    static var darkCell: UIColor? { return UIColor(named: "DarkCell") }

    // 216 216 216
    static var disabledApp: UIColor? { return UIColor(named: "DisabledApp") }
}

extension UIColor {

    enum ListMovie {
        static var favoriteMovie: UIColor? { return .app }
        static var nonFavoriteMovie: UIColor? { return .disabledApp }
    }

}
