//
//  ListMovieViewController.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/28/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation
import UIKit

class ListMovieViewController: UIViewController {

    init() {
        super.init(nibName: "ListMovie", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("This view should not be instantiaded by storyboard")
    }
}
