//
//  GridView.swift
//  ios-recruiting-hsa
//
//  Created on 10-08-19.
//

protocol GridView: class {
    func prepare()
    func showLoading()
    func hideLoading()
    func show(popular movies: [MovieView])
    func show(error: ErrorView)
}
