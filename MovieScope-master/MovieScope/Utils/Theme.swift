//
//  Theme.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/2/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import UIKit

//Manager que se encarga de la apariencia general de la app, se encuentra inconclusa ya que la idea original era que admitiera otros estilos como light o vintage, pero ya será para otra ocasión. No afecta a la arquitectura general de la app.
enum Theme{
    
    case dark
    
    func setTheme(){
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().barTintColor = .appBackgroundColor
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        UIImageView.appearance(whenContainedInInstancesOf: [UICollectionViewCell.self]).backgroundColor = .imageLoadingBackgroundColor
    }
    
}
