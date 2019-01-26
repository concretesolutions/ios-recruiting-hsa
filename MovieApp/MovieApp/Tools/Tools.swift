//
//  Tools.swift
//  MovieApp
//
//  Created by luis.a.rosas.arce on 26/01/19.
//  Copyright © 2019 luis.a.rosas.arce. All rights reserved.
//

import Foundation
import UIKit


class Tools: NSObject {
    
    let standarSize = 15.0
    static let sharedInstance = Tools()
    
    func styleLabelForDetail(label : UILabel) {
        label.font = UIFont(name: "helvetica", size: CGFloat(standarSize))
    }
}

