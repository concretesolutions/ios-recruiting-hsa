//
//  TableViewHeader.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/2/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import UIKit

protocol HomeTableViewHeaderDelegate: class {
    func showMovieList(forSection: Int)
}

class HomeTableViewHeader: UITableViewHeaderFooterView {
    
    let titleLb: UILabel
    let seeAll: UIButton
    
    var currentSectionIndex: Int?
    weak var delegate: HomeTableViewHeaderDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(reuseIdentifier: String?) {
        
        titleLb = UILabel()
        seeAll = UIButton()
       super.init(reuseIdentifier: reuseIdentifier)
        
        addSubview(titleLb)
        addSubview(seeAll)
        
        setStyle()
        applyConstraints()
        
        backgroundView = UIView.init(frame: bounds)
        backgroundView?.backgroundColor = .appBackgroundColor
        
        seeAll.addTarget(self, action: #selector(onButtonPressed(_:)), for: .touchUpInside)
        
        
    }
    
    func applyConstraints(){
        
        let titleLbPadding = UIEdgeInsets.init(top: 12.0, left: 15.0, bottom: 5.0, right: 0.0)
    
        titleLb.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: titleLbPadding, size: .zero)
        
        let buttonPadding = UIEdgeInsets.init(top: 17, left: 0, bottom: 5.0, right: 19.0)
        seeAll.anchor(top: topAnchor, leading: nil, bottom: bottomAnchor, trailing: trailingAnchor, padding: buttonPadding, size: .zero)
    }
    
    func setStyle(){
        titleLb.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        titleLb.textColor = .white
        seeAll.setTitleColor(.lightGray, for: .normal)
        seeAll.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .ultraLight)
        seeAll.setTitle("SEE ALL", for: .normal)
    }
    
    @objc func onButtonPressed(_ sender: UIButton){
        
        guard let section = currentSectionIndex else {
            print("Section nil")
            return
        }
        
        delegate?.showMovieList(forSection: section)
    }
    
}
