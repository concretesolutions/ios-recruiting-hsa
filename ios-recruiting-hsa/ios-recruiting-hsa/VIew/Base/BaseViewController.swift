//
//  BaseViewController.swift
//  ios-recruiting-hsa
//
//  Created on 11-08-19.
//

import UIKit

class BaseViewController: UIViewController {
    private var activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
    
    private func prepareIndicatorView() {
        activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicatorView)
        activityIndicatorView.backgroundColor = Constants.Colors.dark
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicatorView.layer.cornerRadius = activityIndicatorView.bounds.width / 2
    }
}

extension BaseViewController: BaseView {
    @objc
    func prepare() {
        prepareIndicatorView()
    }
    
    func showLoading() {
        view.isUserInteractionEnabled = false
        activityIndicatorView.startAnimating()
    }
    
    func hideLoading() {
        view.isUserInteractionEnabled = true
        activityIndicatorView.stopAnimating()
    }
    
    func show(error: ErrorView) {
        let alertView = UIAlertController(title: "Error", message: error.statusMessage, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertView, animated: true)
    }
}
