//
//  ErrorViewVC.swift
//  concreteMoviesApp
//
//  Created by Nebraska Melendez on 7/29/19.
//  Copyright © 2019 Nebraska Melendez. All rights reserved.
//

import Foundation
import UIKit

class ErrorViewVC : UIView {
    
    //MARK: UIVars
    @IBOutlet weak var errorImage: UIImageView!
    @IBOutlet weak var errorMessage: UILabel!
    
    class func create() -> ErrorViewVC{
        return UINib(nibName: "ErrorView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ErrorViewVC
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}
