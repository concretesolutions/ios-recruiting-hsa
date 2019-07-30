//
//  MovieDetailHeaderView.swift
//  concreteMoviesApp
//
//  Created by Nebraska Melendez on 7/27/19.
//  Copyright © 2019 Nebraska Melendez. All rights reserved.
//

import Foundation
import UIKit


class MovieDetailHeaderView : UIView {
    
    //MARK: UIVars
    
    @IBOutlet weak var moviePoster: UIImageView!
    

    class func create() -> MovieDetailHeaderView{
        return UINib(nibName: "MovieDetailHeader", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! MovieDetailHeaderView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}
