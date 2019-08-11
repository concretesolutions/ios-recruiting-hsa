//
//  Constants.swift
//  ios-recruiting-hsa
//
//  Created on 8/8/19.
//

import UIKit

enum Constants {
    enum ErrorMessages {
        static let serverError = "Ups! Server error!"
    }
    
    enum Colors {
        static let brand: UIColor = #colorLiteral(red: 0.9686772227, green: 0.8077141047, blue: 0.3574544787, alpha: 1) // F7CE5B
        static let dark: UIColor = #colorLiteral(red: 0.1764705882, green: 0.1882352941, blue: 0.2784313725, alpha: 1) // 2D3047
        static let accent: UIColor = #colorLiteral(red: 0.8509803922, green: 0.5921568627, blue: 0.1176470588, alpha: 1) // D9971E
        static let white: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) // FFFFFF
        static let lightGray: UIColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) // 999999
    }
    
    enum Text {
        static let minimumScale: CGFloat = 0.5
        static let numberOfLines = 0
    }
    
    enum Labels {
        static let gridTitle = "Movies"
        static let favoritesTitle = "Favorites"
    }
    
    enum Images {
        static let gridMultiplier: CGFloat = 0.84
    }
}
