//
//  Loading.swift
//  MoviesApp
//
//  Created by gustavo.salazar on 20/06/22.
//

import Foundation
import UIKit

private var aView: UIView?

extension UIViewController {
    func showSpinner() {
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)

        let aIView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        aIView.center = aView!.center
        aIView.startAnimating()
        aView!.addSubview(aIView)
        self.view.addSubview(aView!)
    }
    func removeSpinner() {
        aView?.removeFromSuperview()
        aView = nil
    }

    func isRunning() -> Bool {
        return aView != nil
    }
}
