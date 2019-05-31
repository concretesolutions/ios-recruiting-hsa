//
//  FavoriteMoviesWireframe.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/31/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation
import UIKit

protocol FavoriteMoviesViewDelegate: class {
    func favoriteMovieView(
        _ viewController: FavoriteMoviesViewController,
        didSelect movie: PopularMovie
    )
}

class FavoriteMoviesWireframe {

    static func viewController(
        withDelegate delegate: FavoriteMoviesViewDelegate,
        appDependencies: AppDependencies
    ) -> UIViewController {
        let viewModel = FavoriteMoviesViewModelImpl(
            favoritesManager: appDependencies.favoritesManager
        )
        let controller = FavoriteMoviesViewController(viewModel: viewModel)
        viewModel.onSelectMovie = { [weak delegate, unowned controller] movie in
            delegate?.favoriteMovieView(controller, didSelect: movie)
        }
        return controller
    }
}
