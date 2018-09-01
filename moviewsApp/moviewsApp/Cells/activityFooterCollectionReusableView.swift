//
//  activityFooterCollectionReusableView.swift
//  moviewsApp
//
//  Created by carlos jaramillo on 8/31/18.
//  Copyright © 2018 carlos jaramillo. All rights reserved.
//

import UIKit

class activityFooterCollectionReusableView: UICollectionReusableView {
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.activity.startAnimating()
    }
}
