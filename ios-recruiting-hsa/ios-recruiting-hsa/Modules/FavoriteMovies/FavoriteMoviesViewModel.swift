//
//  FavoriteMoviesViewModel.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/31/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation

protocol FavoriteMoviesViewModel {
    var title: String { get }
}

// Implementation

class FavoriteMoviesViewModelImpl {

}

extension FavoriteMoviesViewModelImpl: FavoriteMoviesViewModel {
    var title: String { return "Favorites" }
}
