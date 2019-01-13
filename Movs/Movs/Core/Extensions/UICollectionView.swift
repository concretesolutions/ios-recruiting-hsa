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
    
    func registerNib(forViewClass viewClass: UICollectionReusableView.Type, forSupplementaryViewOfKind kind: String) {
        let className = String(describing: viewClass)
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: className)
    }
    
    func dequeueReusableSupplementaryView<ViewType: UICollectionReusableView>(withClass viewClass: ViewType.Type, kind: String, at indexPath: IndexPath) -> ViewType {
        let className = String(describing: viewClass)
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: className, for: indexPath) as! ViewType
    }
}
