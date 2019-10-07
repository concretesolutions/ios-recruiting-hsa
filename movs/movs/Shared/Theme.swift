//
//  Theme.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/2/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import UIKit

class ThemeManager{
    
    static var instance = ThemeManager()
    private init(){}
    
    func setTheme(){
        setupNavigationBar()
    }
    
    private func setupNavigationBar(){
        UINavigationBar.appearance().barTintColor = .lightOrange
        UINavigationBar.appearance().tintColor = .darkNavy
        UITabBar.appearance().barTintColor = .lightOrange
        UITabBar.appearance().tintColor = .darkNavy
    }

}
