//
//  DetailView.swift
//  ios-recruiting-hsa
//
//  Created on 11-08-19.
//

protocol DetailView: BaseView {
    func show(detail movie: MovieDetailView)
    func markFavorite()
}
