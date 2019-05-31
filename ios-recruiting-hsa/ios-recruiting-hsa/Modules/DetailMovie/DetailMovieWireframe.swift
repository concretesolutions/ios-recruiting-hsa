//
//  DetailMovieWireframe.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/31/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation
import UIKit

class DetailMovieWireframe {
    static func viewController(
        movie: PopularMovie,
        appDependencies: AppDependencies
    ) -> UIViewController {
        let viewModel = DetailMovieViewModelImpl(
            movie: movie,
            favoritesManager: appDependencies.favoritesManager,
            genreManager: appDependencies.genreManager
        )
        let controller = DetailMovieViewController(viewModel: viewModel)
        return controller
    }
}
