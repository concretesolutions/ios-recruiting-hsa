//
//  ReusableViewIdentifier.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/4/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import UIKit

protocol ReusableView: class {
    static var reuseIdentifier: String {get}
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
extension UITableViewCell: ReusableView {}
extension UICollectionViewCell: ReusableView{}
extension UITableViewHeaderFooterView: ReusableView{}
