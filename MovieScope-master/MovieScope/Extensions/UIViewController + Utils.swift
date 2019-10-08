//
//  UIViewController + Utils.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/11/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func displayAlertMsg(title: String = "Error", msg: String){
        
        let alertController = UIAlertController.init(title: title, message: msg, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil))
       
        self.present(alertController, animated: true, completion: nil)
    }
    
}
