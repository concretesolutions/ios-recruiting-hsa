//
//  Images.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/10/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import UIKit

extension UIImage{
    
    class var notFoundImage: UIImage?{
        return UIImage.init(named: "not_found")
    }
    
    class var glassIcImage: UIImage?{
        return UIImage.init(named: "glasses_ic")?.withRenderingMode(.alwaysTemplate)
    }
    
    class var starIc: UIImage?{
        return UIImage.init(named: "star_icon")?.withRenderingMode(.alwaysTemplate)
    }
    
    class var heartIc:UIImage?{
        return UIImage.init(named: "heart_ic")?.withRenderingMode(.alwaysTemplate)
    }
    
    class var handUpIc:UIImage?{
        return UIImage.init(named: "thumbsup_ic")?.withRenderingMode(.alwaysTemplate)
    }
    
    class var handDownIc:UIImage?{
        return UIImage.init(named: "thumbsdown_ic")?.withRenderingMode(.alwaysTemplate)
    }
}
