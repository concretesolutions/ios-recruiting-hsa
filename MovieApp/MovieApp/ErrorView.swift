//
//  ErrorView.swift
//  MovieApp
//
//  Created by Sebastian Diaz on 4/7/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import UIKit

class ErrorView: UIView {
    
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var errorImageView: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("ErrorView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
    }

}
