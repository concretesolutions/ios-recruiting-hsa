//
//  FavoriteMoviesWireframe.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/31/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation
import UIKit

class FavoriteMoviesWireframe {

    static func viewController(appDependencies: AppDependencies) -> UIViewController {
        let viewModel = FavoriteMoviesViewModelImpl(
            favoritesManager: appDependencies.favoritesManager
        )
        let controller = FavoriteMoviesViewController(viewModel: viewModel)
        return controller
    }
}
