//
//  UICollectionView.swift
//  TMDB Reloaded
//
//  Created by Miguel Duran on 1/6/19.
//  Copyright © 2019 Miguel Duran. All rights reserved.
//

import UIKit

extension UICollectionView {
    func registerNib(forCellClass cellClass: UICollectionViewCell.Type) {
        let className = String(describing: cellClass)
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellWithReuseIdentifier: className)
    }
    
    func dequeueReusableCell<CellType: UICollectionViewCell>(at indexPath: IndexPath) -> CellType {
        let identifier = String(describing: CellType.self)
        return dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! CellType
    }
}
