//
//  BaseView.swift
//  ios-recruiting-hsa
//
//  Created on 11-08-19.
//

protocol BaseView: class {
    func prepare()
    func showLoading()
    func hideLoading()
    func show(error: ErrorView)
}
