//
//  Wireframe.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/2/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import UIKit

protocol Wireframe {
    var navigation: UINavigationController { get }
    init(navigation: UINavigationController)
}
