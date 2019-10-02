//
//  HomeMovieModule.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/2/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import UIKit

class HomeMovieModule {
    
    private let router: HomeMovieRouter
    
    init(navigation: UINavigationController) {
        self.router = HomeMovieRouter(navigation: navigation)
    }
    
    func presentHome(){
        router.showHome()
    }
    
}
