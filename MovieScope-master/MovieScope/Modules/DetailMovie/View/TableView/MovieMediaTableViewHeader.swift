//
//  MovieMediaTableViewHeader.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/8/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import UIKit

class MovieMediaTableViewHeader: UITableViewHeaderFooterView {

    let titleLb: UILabel
    
    override init(reuseIdentifier: String?) {
        
        titleLb = UILabel()
        super.init(reuseIdentifier: reuseIdentifier)
        
        addSubview(titleLb)
        
        setStyle()
        applyConstraints()
        
        backgroundView = UIView.init(frame: bounds)
        backgroundView?.backgroundColor = .appBackgroundColor
    }
    
    func applyConstraints(){
        
        let titleLbPadding = UIEdgeInsets.init(top: 9.0, left: 12.0, bottom: 7.0, right: 19.0)
        
        titleLb.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: titleLbPadding, size: .zero)
        
    }
    
    func setStyle(){
        titleLb.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        titleLb.textColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
