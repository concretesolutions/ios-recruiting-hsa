//
//  FavoritesRouter.swift
//  MovieApp
//
//  Created by DeveloperOSA on 4/9/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import Foundation
import UIKit

protocol FavoritesRouterProtocol {
    var presentingViewController : UIViewController!{get set}
    
    func showFavoriteFilter()
}

class FavoritesRouter {
    var presentingViewController: UIViewController!
    
    init(presenting : UIViewController){
        self.presentingViewController = presenting
    }
}

extension FavoritesRouter : FavoritesRouterProtocol {
    func showFavoriteFilter() {
        let dest = FilterMovieViewController(nibName: "FilterMovieViewController", bundle: nil)
        presentingViewController.show(dest, sender: nil)
    }
}


