//
//  ListMovieWireframe.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/30/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation
import UIKit

protocol ListMovieViewDelegate: class {
    func listMovieView(_ viewController: ListMovieViewController, didSelect movie: PopularMovie)
}

class ListMovieWireframe {

    static func viewController(
        withDelegate delegate: ListMovieViewDelegate,
        navigationBar: UINavigationBar,
        appDependencies: AppDependencies
    ) -> UIViewController {
        let viewModel = ListMovieViewModelImpl(
            modelManager: appDependencies.modelManager,
            favoritesManager: appDependencies.favoritesManager
        )
        let controller = ListMovieViewController(
            navigationBar: navigationBar,
            viewModel: viewModel
        )
        viewModel.onSelectedMovie = { [weak delegate, unowned controller] movie in
            delegate?.listMovieView(controller, didSelect: movie)
        }
        return controller
    }
}
