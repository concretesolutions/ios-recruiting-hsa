//
//  FavoriteView.swift
//  ios-recruiting-hsa
//
//  Created on 8/12/19.
//

protocol FavoriteView: BaseView {
    func show(favorite movies: [FavoriteMovieView])
    func deleted()
}
