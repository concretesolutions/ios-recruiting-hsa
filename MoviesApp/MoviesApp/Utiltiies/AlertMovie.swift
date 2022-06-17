//
//  Alert.swift
//  MoviesApp
//
//  Created by gustavo.salazar on 17/06/22.
//

import Foundation
import UIKit

struct AlertMovie {
   

    static func showBasicAlert(in viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction( title: AlertConstant.OK, style: .default, handler: nil))
         DispatchQueue.main.async { viewController.present(alert, animated: true) }
    }
    
}
