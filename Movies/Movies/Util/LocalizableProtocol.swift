//
//  LocalizableProtocol.swift
//  Movies
//
//  Created by Consultor on 12/18/18.
//  Copyright © 2018 Mavzapps. All rights reserved.
//

import UIKit

protocol Localizable {
    var localized: String { get }
}
extension String: Localizable {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
protocol XIBLocalizable {
    var xibLocKey: String? { get set }
}
extension UITabBarItem: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            title = key?.localized
        }
    }
}
