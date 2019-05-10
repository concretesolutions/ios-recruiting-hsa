//
//  MTACustomMovieTableCell.swift
//  MovieApp
//
//  Created by Andres Ortiz on 4/17/19.
//  Copyright © 2019 Andres. All rights reserved.
//


import Foundation
import UIKit


class MTACustomMovieTableCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        setupLayout()
    }
    
    let imgMoviePoster : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .black
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let lblMovieTitle : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    let lblMovieOverview : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.numberOfLines = 5
        label.textColor = .darkGray
        label.textAlignment = .justified
        return label
    }()
    
    let btMoviePreview : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.contentMode = .scaleAspectFit
        button.setTitle("Pre", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 20
        return button
    }()
    
    func setupLayout(){
        addSubview(imgMoviePoster)
        imgMoviePoster.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        imgMoviePoster.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        imgMoviePoster.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imgMoviePoster.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        addSubview(lblMovieTitle)
        lblMovieTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        lblMovieTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 90).isActive = true
        lblMovieTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        
        addSubview(lblMovieOverview)
        lblMovieOverview.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        lblMovieOverview.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 90).isActive = true
        lblMovieOverview.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -65).isActive = true
        
        addSubview(btMoviePreview)
        btMoviePreview.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
        btMoviePreview.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        btMoviePreview.widthAnchor.constraint(equalToConstant: 40).isActive = true
        btMoviePreview.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
