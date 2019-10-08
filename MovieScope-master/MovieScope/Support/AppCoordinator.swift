//
//  AppCoordinator.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/2/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import UIKit

class AppCoodinator: Coordinator{
  
    override func start() {
        
//        guard let navigationPresenter = self.navController else{
//            print("Navigation no instanciado")
//            return
//        }
        let homeCoord = HomeMovieCoordinator.init(navigationController: navController, nameid: CoordinatorKeys.Home.rawValue, parentdelegate: self)
        homeCoord.start()
        addChildCoordinator(child: homeCoord)
        
    }
    
}
