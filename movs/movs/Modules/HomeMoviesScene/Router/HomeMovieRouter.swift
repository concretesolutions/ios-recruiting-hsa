//
//  HomeMovieRouter.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/2/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import UIKit

class HomeMovieRouter: Wireframe {
    
    var navigation: UINavigationController
    
    required init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func showHome(){
        let homeViewController = HomeViewController()
        navigation.pushViewController(homeViewController, animated: true)
    }
}
