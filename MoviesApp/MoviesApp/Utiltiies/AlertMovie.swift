//
//  Alert.swift
//  MoviesApp
//
//  Created by gustavo.salazar on 17/06/22.
//

import Foundation
import UIKit

struct AlertMovie {

    static func showBasicAlert(in viewController: UIViewController, title: String, message: String,
                               imageName: String="") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction( title: AlertConstant.AlertOK, style: .default, handler: nil)
        alert.addAction(action)
         DispatchQueue.main.async {
             viewController.present(alert, animated: true) }
    }
}
